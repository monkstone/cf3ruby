require_relative '../lib/cf3.rb'

def settings
  size 200, 200
end

def setup
  sketch_title 'Test'
  @triangle = ContextFree.define do
    shape :tri do
      circle
      triangle brightness: 0.8
      square brightness: 0.02, size: 0.02
    end
  end
end

def draw_it
  background 0.2
  @triangle.render :tri, size: height/2
end

def draw
  # Do nothing.
end

def mouse_clicked
  draw_it
end
