require 'cf3'
#############
# to be fixed
#############

GOLD = [33, 0.967, 0.592, 1]
BLACK = [0, 0.909, 0.129, 1]
GREEN = [148, 0.696, 0.271, 1]
BLUE = [225, 0.777, 0.475, 1]
RED = [17, 0.983, 0.231, 1]
COLORS = [GOLD, BLACK, GREEN, BLUE, RED]

def setup_the_tiles
  @tiles= ContextFree.define do
    ############ Begin defining custom terminal, an wavy_triangle triangle        
    class << self    
      define_method(:wavy_triangle) do |some_options| # wavy_triangle triangle
        size, options = *self.get_shape_values(some_options)
        rot = options[:rotation]
        disp = 0.32          # could introduce a rule option?
        x0 = options[:x]
        y0 = options[:y]
        pts = Array.new(12)
        pts[0] = PVector.new(x0, y0 - size/Math.sqrt(3))                  # A
        pts[1] = PVector.new(x0 - 0.5 * size, y0 + (Math.sqrt(3)*size)/6) # B
        pts[2] = PVector.new(x0 + 0.5 * size, y0 + (Math.sqrt(3)*size)/6) # C
        pts[3] = get_mid_point(pts[0], pts[1])                            # Ab
        pts[4] = get_mid_point(pts[1], pts[2])                            # Bc
        pts[5] = get_mid_point(pts[0], pts[2])                            # Ca
        pts[6] = get_mid_point(pts[0], pts[3])                            # Aba
        adjust_bezier(pts[6], PI/3, disp*size)                            # Aba
        pts[7] = get_mid_point(pts[3], pts[1])                            # Abb
        adjust_bezier(pts[7], PI/3, -disp*size)                           # Abb
        pts[8] = get_mid_point(pts[1], pts[4])
        adjust_bezier(pts[8], PI/2, -disp*size)
        pts[9] = get_mid_point(pts[4], pts[2])
        adjust_bezier(pts[9], PI/2, disp*size)
        pts[10] = get_mid_point(pts[2], pts[5])
        adjust_bezier(pts[10], -PI/3, -disp*size)
        pts[11] = get_mid_point(pts[5], pts[0])
        adjust_bezier(pts[11], -PI/3, disp*size)
        rotate(rot) if rot
        begin_shape
          vertex(pts[0].x, pts[0].y)
          bezier_vertex(pts[0].x, pts[0].y, pts[6].x, pts[6].y, pts[3].x, pts[3].y)
          bezier_vertex(pts[3].x, pts[3].y, pts[7].x, pts[7].y, pts[1].x, pts[1].y)
          bezier_vertex(pts[1].x, pts[1].y, pts[8].x, pts[8].y, pts[4].x, pts[4].y)
          bezier_vertex(pts[4].x, pts[4].y, pts[9].x, pts[9].y, pts[2].x, pts[2].y)
          bezier_vertex(pts[2].x, pts[2].y, pts[10].x, pts[10].y, pts[5].x, pts[5].y)
          bezier_vertex(pts[5].x, pts[5].y, pts[11].x, pts[11].y, pts[0].x, pts[0].y)
        end_shape(CLOSE)        
        rotate(-rot) if rot
      end
    
      private
      def adjust_bezier(base, theta, disp)
        base.add(PVector.new(Math.cos(theta)*disp, Math.sin(theta)*disp))
      end
    
      def get_mid_point(a, b)
        mid = PVector.add(a, b)
        mid.div(2)
        return mid
      end
    end
  
    ########### End definition of custom terminal 'wavy_triangle' shape
    shape :tiles do
      20.times do |i|
        20.times do |j|
	  split do	
            wavy_triangle size: 1, x: (i + 0.5 * j%2), y: j * 0.9, color: COLORS[i % 5]
	    rewind
	    star size: 0.4, x: (2.5 * i - 1.25 * j%2) +0.4, y: (j * 2.5 * 0.9) + 1.25, color: COLORS[j % 5]
	  end
        end
      end
    end

    shape :star do
      triangle 
      triangle rotation: 180
    end
  end
end

def setup
  size 1024, 720
  background 255
  smooth
  setup_the_tiles
  draw_it
end

def draw_it
  @tiles.render :tiles, start_x: -200, start_y: 0,
               size: height/6
end
