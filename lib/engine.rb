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
    
    # Create a camera
    @camera = Camera.new(0,0)
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
    
    update_camera
  end
  
  def update_camera
    @camera.parax = @player.body.p.x
    @camera.paray = @player.body.p.y

    if CAMERA_BEHAVIOR==:stop_at_world_edge
      if (@player.body.p.x - SCREEN_WIDTH / 2 < 0)
        @camera.x = 0
      elsif (@player.body.p.x + SCREEN_WIDTH / 2) > WORLD_WIDTH
        @camera.x = (WORLD_WIDTH - SCREEN_WIDTH
      else
        @camera.x = @player.body.p.x - SCREEN_WIDTH / 2
      end
    else
      @camera.x = @player.body.p.x - SCREEN_WIDTH / 2
    end

    if (@player.body.p.y - SCREEN_HEIGHT / 2 < 0)
      @camera.y = 0
    elsif (@player.body.p.y + SCREEN_HEIGHT / 2 > WORLD_HEIGHT)
      @camera.y = WORLD_HEIGHT - SCREEN_HEIGHT
    else
      @camera.y = @player.body.p.y - SCREEN_HEIGHT / 2
    end
  end
  
  def draw 
    @map.draw(@camera)
    @player.draw(@camera)
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end