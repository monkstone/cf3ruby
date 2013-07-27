#################################################################
# tree4.rb by Martin Prout after tree4.cfdg
# A non deterministic sketch run it until you get a result you like
# uncomment "srand 5" to get a more deterministic result. It looked
# pretty good on my linux box (however I'm not sure how universal the 
# random seeding is in jruby)
#################################################################

require 'cf3'

def setup_the_tree
  @tree = ContextFree.define do
    shape :trunk, 20 do                     # rule has a probability weighting of 20
      circle size: 0.25, brightness: 0.5    # giving an actual probability = 0.952381
      scraggle y: -0.1                      # the minus is require by the upside down coordinate system             
    end

    shape :trunk, 1 do                      # rule has a probability weighting of 1
      branch size: 0.7                      # giving an actual probability = 0.047619  
    end

    shape :trunk, 0.02 do                    # empty rule top stop early    
    end

    shape :branch do
      split do                               # split is like a branch, rewind returns original context
        trunk rotation: 10
      rewind
        trunk rotation: -10
      end
    end

    shape :scraggle do                       # without an explicit weighting    
      trunk rotation: 5                      # probability of each scraggle rule 
    end                                      # is 0.5

    shape :scraggle do
      trunk rotation: -5
    end
  end
end

def setup
  size 600, 600
  # srand 5  uncomment this to get nice looking tree
  smooth
  setup_the_tree
  background 255         # NB color mode here is "RGB 255", within context free definition 
  draw_it                # the color mode is "HSB 1.0", supports :hue, :saturation, :brightness
  # save_frame "/home/tux/tree4.png"
end

def draw
  # create a draw loop
end

def draw_it
  @tree.render :trunk, start_x: width/2, start_y: height * 0.9, stop_size: height/150, size: height/15
end

def mouse_clicked
  java.lang.System.gc  # might help to reduce runtime stack blow ups, it happens!
  background 1
  draw_it
end
