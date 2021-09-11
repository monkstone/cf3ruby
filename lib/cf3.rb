module Processing
  # A Context-Free library for JRubyArt, inspired by and
  # based on context_free.rb by Jeremy Ashkenas. That in turn
  # was inspired by contextfreeart.org
  class ContextFree
    include Processing::Proxy
    attr_accessor :rule, :app, :width, :height

    AVAILABLE_OPTIONS = %i[
      x y w h rotation size flip color hue saturation brightness alpha
    ].freeze
    HSB_ORDER       = { hue: 0, saturation: 1, brightness: 2, alpha: 3 }.freeze
    TRIANGLE_TOP    = -1 / Math.sqrt(3)
    TRIANGLE_BOTTOM = Math.sqrt(3) / 6
    RADIANS = (Math::PI / 180.0)
    # Define a context-free system. Use this method to create a ContextFree
    # object. Call render() on it to make it draw.
    def self.define(&block)
      cf = ContextFree.new
      cf.instance_eval(&block)
      cf
    end

    # Initialize a bare ContextFree object with empty recursion stacks.
    def initialize
      @app = Processing.app
      @graphics     = @app.g
      @width        = @app.width
      @height       = @app.height
      @rules        = {}
      @rewind_stack = []
      @matrix_stack = []
    end

    # Create an accessor for the current value of every option. We use a values
    # object so that all the state can be saved and restored as a unit.
    AVAILABLE_OPTIONS.each do |option_name|
      define_method option_name do
        @values[option_name]
      end
    end

    # Here's the first serious method: A Rule has an
    # identifying name, a probability, and is associated with
    # a block of code. These code blocks are saved, and indexed
    # by name in a hash, to be run later, when needed.
    # The method then dynamically defines a method of the same
    # name here, in order to determine which rule to run.
    def shape(rule_name, prob = 1, &proc)
      @rules[rule_name] ||= { procs: [], total: 0 }
      total = @rules[rule_name][:total]
      @rules[rule_name][:procs] << [(total...(prob + total)), proc]
      @rules[rule_name][:total] += prob
      return if ContextFree.method_defined? rule_name

      instance_eval do
        eval <<-METH
        def #{rule_name}(options)
          merge_options(@values, options)
          pick = determine_rule(#{rule_name.inspect})
          return if (@values[:size] - @values[:stop_size]) < 0
          prepare_to_draw
          pick[1].call(options)
        end
        METH
      end
    end

    # Rule choice is random, based on the assigned probabilities.
    def determine_rule(rule_name)
      rule = @rules[rule_name]
      chance = rand(0.0..rule[:total])
      @rules[rule_name][:procs].select do |the_proc|
        the_proc[0].include?(chance)
      end.flatten
    end

    # At each step of the way, any of the options may change, slightly.
    # Many of them have different strategies for being merged.
    def merge_options(old_ops, new_ops)
      return unless new_ops

      # Do size first
      old_ops[:size] *= new_ops.fetch(:size, 1.0)
      new_ops.each do |key, value|
        case key
        # when :size
        when :x, :y
          old_ops[key] = value * old_ops.fetch(:size, 1.0)
        when :rotation
          old_ops[key] = value * RADIANS
        when :hue, :saturation, :brightness, :alpha
          adjusted = old_ops[:color].dup
          adjusted[HSB_ORDER[key]] *= value unless key == :hue
          adjusted[HSB_ORDER[key]] += value if key == :hue
          old_ops[:color] = adjusted
        when :flip
          old_ops[key] = !old_ops[key]
        when :w, :h
          old_ops[key] = value * old_ops.fetch(:size, 1.0)
        when :color
          old_ops[key] = value
        else # Used a key that we don't know about or trying to set
          merge_unknown_key(key, value, old_ops)
        end
      end
    end

    # Using an unknown key let's you set arbitrary values,
    # to keep track of for your own ends.
    def merge_unknown_key(key, value, old_ops)
      key_s = key.to_s
      return unless key_s =~ /^set/
      key_sym = key_s.sub('set_', '').to_sym
      if key_s =~ /(brightness|hue|saturation)/
        adjusted = old_ops[:color].dup
        adjusted[HSB_ORDER[key_sym]] = value
        old_ops[:color] = adjusted
      else
        old_ops[key_sym] = value
      end
    end

    # Doing a 'split' saves the context, and proceeds from there,
    # allowing you to rewind to where you split from at any moment.
    def split(options = nil)
      save_context
      merge_options(@values, options) if options
      yield
      restore_context
    end

    # Saving the context means the values plus the coordinate matrix.
    def save_context
      @rewind_stack.push @values.dup
      @matrix_stack << @graphics.get_matrix
    end

    # Restore the values and the coordinate matrix as the recursion unwinds.
    def restore_context
      @values = @rewind_stack.pop
      @graphics.set_matrix @matrix_stack.pop
    end

    # Rewinding goes back one step.
    def rewind
      restore_context
      save_context
    end

    # Render the is method that kicks it all off, initializing the options
    # and calling the first rule.
    def render(rule_name, starting_values = {})
      @values = defaults
      @values.merge!(starting_values)
      @app.reset_matrix
      @app.rect_mode CENTER
      @app.ellipse_mode CENTER
      @app.no_stroke
      @app.color_mode HSB, 360, 1.0, 1.0, 1.0 # match cfdg
      @app.translate @values.fetch(:start_x, 0), @values.fetch(:start_y, 0)
      send(rule_name, {})
    end

    def defaults
      {
        x: 0,
        y: 0,
        rotation: 0,
        flip: false,
        size: 20,
        start_x: width / 2,
        start_y: height / 2,
        color: [180, 0.5, 0.5, 1],
        stop_size: 1.5
      }
    end

    # Before actually drawing the next step, we need to move to the appropriate
    # location.
    def prepare_to_draw
      @app.translate(@values.fetch(:x, 0), @values.fetch(:y, 0))
      sign = (@values[:flip] ? -1 : 1)
      @app.rotate(sign * @values[:rotation])
    end

    # Compute the rendering parameters for drawing a shape.
    def get_shape_values(some_options)
      old_ops = @values.dup
      merge_options(old_ops, some_options) unless some_options.empty?
      @app.fill(*old_ops[:color])
      old_ops
    end

    # Square, circle, ellipse and triangles are the primitive shapes
    def square(some_options = {})
      options = get_shape_values(some_options)
      width = options[:w] || options[:size]
      height = options[:h] || options[:size]
      rot = options[:rotation]
      @app.rotate(rot) if rot
      @app.rect(0, 0, width, height)
      @app.rotate(-rot) if rot
    end

    def circle(some_options = {})
      get_shape_values(some_options)
      @app.ellipse(0, 0, size, size)
    end

    def triangle(some_options = {})
      options = get_shape_values(some_options)
      rot = options[:rotation]
      @app.rotate(rot) if rot
      @app.triangle(0, TRIANGLE_TOP * size, 0.5 * size, TRIANGLE_BOTTOM * size, -0.5 * size, TRIANGLE_BOTTOM * size)
      @app.rotate(-rot) if rot
    end

    def ellipse(some_options = {})
      options = get_shape_values(some_options)
      width = options[:w] || options[:size]
      height = options[:h] || options[:size]
      rot = some_options[:rotation]
      @app.rotate(rot) if rot
      @app.oval(options[:x] || 0, options[:y] || 0, width, height)
      @app.rotate(-rot) if rot
    end
    alias oval ellipse
  end
end
