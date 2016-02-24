require 'gosu'
require './lib/constants.rb' 

class Camera
  attr_accessor :x, :y, :zoom
  
  def initialize(target)
    @target = target
    @x = @y = 0
    @zoom = 1
  end
  
  def update
    @x += @target.speed if @x < @target.x - $window.width / 4
    @x -= @target.speed if @x > @target.x + $window.width / 4
    @y += @target.speed if @y < @target.y - $window.height / 4
    @y -= @target.speed if @y > @target.y + $window.height / 4
  end
  
  def can_view?(x, y, obj)
    x0, x1, y0, y1 = viewport
    (x0 - obj.width..x1).include?(x) &&
    (y0 - obj.height..y1).include?(y)
  end

  def viewport
    x0 = @x - ($window.width / 2)  / @zoom
    x1 = @x + ($window.width / 2)  / @zoom
    y0 = @y - ($window.height / 2) / @zoom
    y1 = @y + ($window.height / 2) / @zoom
    [x0, x1, y0, y1]
  end
end