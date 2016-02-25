require 'chipmunk'

require './lib/constants.rb' 

class Camera
  attr_accessor :x, :y, :parax, :paray
  
  def initialize(x, y)
    @x = @y = x.to_f, y.to_f
    @zoom = 1
  end
  
  # def update
  #   @x += @target.speed if @x < @target.x - $window.width / 4
  #   @x -= @target.speed if @x > @target.x + $window.width / 4
  #   @y += @target.speed if @y < @target.y - $window.height / 4
  #   @y -= @target.speed if @y > @target.y + $window.height / 4
  # end
  
  # def can_view?(x, y, obj)
  #   x0, x1, y0, y1 = viewport
  #   (x0 - obj.width..x1).include?(x) &&
  #   (y0 - obj.height..y1).include?(y)
  # end
  #
  # def viewport
  #   x0 = @x - ($window.width / 2)  / @zoom
  #   x1 = @x + ($window.width / 2)  / @zoom
  #   y0 = @y - ($window.height / 2) / @zoom
  #   y1 = @y + ($window.height / 2) / @zoom
  #   [x0, x1, y0, y1]
  # end
  
  def world_to_screen(world_coords)
    world_coords - self.to_vec2
  end

  def screen_to_world(screen_coords)
    self.to_vec2 + screen_coords
  end

  def x_parallax_world_to_screen(world_coords, scroll_rate_offset)
    paraself = @parax ? CP::Vec2.new(@parax, @y) : CP::Vec2::ZERO
    screen_coords = world_coords - paraself
    CP::Vec2.new(screen_coords.x / (scroll_rate_offset * PARALLAX_SEPARATION_FACTOR), screen_coords.y)
  end

  def to_vec2
    CP::Vec2.new(self.x, self.y)
  end

  def to_a
    [x, y]
  end
end