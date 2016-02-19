require 'gosu'

require './lib/constants'
require './objects/player.rb'

class GameWindow < Gosu::Window
  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT, false
    self.caption = 'Roguelike'
    
    # Load background from media folder
    @background = Gosu::Image.new(self, "#{BACKGROUNDS_DIR}/country_field.png", false)
    
    # Create a player
    @player = Player.new(self, 128, 128)
  end
  
  def draw
    @background.draw(0, 0, 0)
    @player.draw
  end
end