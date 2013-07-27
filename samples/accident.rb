#########################
# rubystar.rb 
#########################
require 'cf3' 

PHI = (1 + Math.sqrt(5)) / 2

def setup_the_sunstar
  @hexa = ContextFree.define do
  ############ Begin defining custom terminals, as a sharp and flat triangles 
    class << self
    include Math
      define_method(:sharp) do |some_options| 
        size, options = *self.get_shape_values(some_options)
        rot = options[:rotation]        
        #f = (options[:flip])? -1 : 1
        @app.rotate(rot) if rot 
        #@app.triangle(0, 0, size * cos(0), size * sin(0), size * cos(PI * f/5), size * sin(PI*f/5))
        @app.triangle(0, 0, size * cos(0), size * sin(0), size * cos(PI/5), size * sin(PI/5))
        @app.rotate(-rot) if rot
      end
      define_method(:flat) do |some_options| 
        size, options = *self.get_shape_values(some_options)
        rot = options[:rotation]
        f = (options[:flip])? -1 : 1                           # NB custom flip adjustment
        @app.triangle(0, 0, size * cos(0), size * sin(0), size/PHI * cos(PI * f/5 ), size/PHI * sin(PI * f/5))
        @app.rotate(-rot) if rot
      end
    end
    ########### End definition of custom terminals 'sharp and flat'
    
    shape :tiling do
      outer brightness: 1.0
    end
  
    
    shape :outer do
      split do
      10.times do       
        sunstar y: sqrt((PHI)** - 0.125), rotation: 36
      end
      rewind
      end
      outer size: 1/PHI
    end  
    
    
    shape :sunstar do
      split do
      sun brightness: 0.8 
      rewind
      star brightness: 0.8, alpha: 0.8
      rewind
      end
    end
    
    shape :dart do
      flat size: 1, color: [0.18, 0.6, 0.6] 
      flat size: 1, color: [0.18, 1.0, 1.0], flip: true
    end
    
    shape :kite do 
      sharp size: 1, color: [0, 0.6, 0.6] 
      sharp size: 1, color: [0, 1.0, 1.0], rotation: 180, flip: true
    end
    
    shape :star do      
      split do
        5.times do |i|
          dart rotation: 72 * i 
          rewind
        end
      end
    end
    
    shape :sun do
      split do
        5.times do |i|
          kite rotation: 72 * i
          rewind
        end
      end
    end
  end
end

def setup
  size 800, 820
  background 150, 20, 0 
  smooth
  setup_the_sunstar
  draw_it
end

def draw_it
  @hexa.render :tiling, start_x: width * 0.75, start_y: height/2.64, 
               size: height/6 
end
