# levy.rb ruby-processing NB: :alpha is now implemented ruby-processing
load_libraries 'cf3', 'pdf'
include_package 'processing.pdf'

def setup_the_levy
    @levy = ContextFree.define do
        shape :start do
            levy brightness: 0.9
        end
        shape :levy do
            square alpha: 0.1
            split do
                levy  size: 1/Math.sqrt(2), rotation: -45, x: 0.5, brightness: 0.9
                rewind
                levy  size: 1/Math.sqrt(2), rotation: 45, x: 0.5, brightness: 0.9
            end
        end
    end
end


def setup
    size 2000, 2000, PDF, "levy.pdf"
    my_font = createFont("/usr/share/fonts/TTF/DejaVuSans.ttf", 24)
    textFont(my_font)
    textSize(24)
    textMode(SHAPE)   
    setup_the_levy  
end


def draw
    draw_it
    exit
end


def draw_it
    background 255
    fill = 0
    z = 0
    loadStrings("pdf_levy.rb").each do |line|
        text(line, 10, 10 + z)
        z += 20
    end    
    #@levy.render :start, size: 600,  stop_size: 4,
   # start_x: width/4, start_y: height * 0.8
end
