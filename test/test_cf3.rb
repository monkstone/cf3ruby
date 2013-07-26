require_relative '../lib/cf3.rb'

def setup
  size 200, 200 
  @triangle = ContextFree.define do
    shape :tri do
      circle      
      triangle brightness: 0
      circle brightness: 10, size: 0.02
    end
  end 
  color_mode HSB, 1.0
end

def draw_it
  background 1.0  
  @triangle.render :tri, size: height/2
end

def draw
  # Do nothing.
end

def mouse_clicked
  draw_it
end
