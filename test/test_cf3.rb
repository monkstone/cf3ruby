require_relative '../lib/cf3.rb'

def settings
  size 200, 200
end

def setup
  sketch_title 'Test'
  @triangle = ContextFree.define do
    shape :tri do
      circle brightness: 1.0, sat: 1.0, hue: 200
      triangle brightness: 0.8, hue: 60
      square brightness: 0.02, size: 0.05
    end
  end
end

def draw_it
  background 255, 255, 0 # NB: default color_mode here
  @triangle.render :tri, size: height / 2.0
end

def draw
  # Do nothing.
end

def mouse_clicked
  draw_it
end
