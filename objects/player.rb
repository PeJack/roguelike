require 'gosu'

require './lib/constants'
require './lib/engine.rb'

class Player
  def self.load_animation(window)
    
  end
  
  def initialize(window, x, y)
    #Init starting coordinates
    @x, @y = x, y
  
    #Init facing dir
    # @fdir = :right
    
    # Load animations
    @standing = Gosu::Image.load_tiles(window, "#{IMAGES_DIR}/pirate/idle_0.png", 50, 50, false)
    @run0 = Gosu::Image.load_tiles(window, "#{IMAGES_DIR}/pirate/run_0.png", 50, 50, false)
    @run1 = Gosu::Image.load_tiles(window, "#{IMAGES_DIR}/pirate/run_1.png", 50, 50, false)
    @run2 = Gosu::Image.load_tiles(window, "#{IMAGES_DIR}/pirate/run_2.png", 50, 50, false)
    @run3 = Gosu::Image.load_tiles(window, "#{IMAGES_DIR}/pirate/run_3.png", 50, 50, false)
    @run4 = Gosu::Image.load_tiles(window, "#{IMAGES_DIR}/pirate/run_4.png", 50, 50, false)
    @run5 = Gosu::Image.load_tiles(window, "#{IMAGES_DIR}/pirate/run_5.png", 50, 50, false)
    
    # the current image depends on his activity
    @cur_image = @standing            
  end
  
  def update
    if button_down?(Gosu::KbLeft)
      @x -= 1
    end 
    @x += 1 if button_down?(Gosu::KbRight)
    @y -= 1 if button_down?(Gosu::KbUp)
    @y += 1 if button_down?(Gosu::KbDown)    
  end
  
  def draw

  end
  
end