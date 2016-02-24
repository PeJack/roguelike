require 'gosu'

require './lib/constants.rb'
require './entities/player.rb'
require './entities/map.rb'
require './entities/camera.rb'


class GameWindow < Gosu::Window
  def initialize
    super WORLD_WIDTH, WORLD_HEIGHT, false
    self.caption = 'Roguelike'
    
    # Load background from media folder
    @map = Map.new
    
    # Create a player
    @player = Player.new
    @player.warp(320, 240)
    
    # Create a camera
    @camera = Camera.new(@player)
  end
  
  def update
    if Gosu::button_down? Gosu::KbA # move left
      @player.move(-@player.speed, 0, -1)  
    end
    if Gosu::button_down? Gosu::KbD # move right
      @player.move(@player.speed, 0, 1)    
    end
    if Gosu::button_down? Gosu::KbW # move up
      @player.move(0, -@player.speed)    
    end
    if Gosu::button_down? Gosu::KbS # move down
      @player.move(0, @player.speed)       
    end
    if Gosu::button_down? Gosu::KbSpace # attack
      @player.attack
    end
    
    @camera.update
  end
  
  def draw 
    cam_x = @camera.x
    cam_y = @camera.y
    off_x = width / 2 - cam_x
    off_y = height / 2 - cam_y

    translate(off_x, off_y) do
      @map.draw
    end
    @player.draw
    
    self.caption = "P_X: #{@player.x}; P_Y: #{@player.y}; CAM_X: #{@camera.x}; CAM_Y: #{@camera.y}; OFFSET: #{[off_x, off_y]}; FPS: #{Gosu.fps}"
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end