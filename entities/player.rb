require 'gosu'
require './lib/constants.rb'

class Player
  attr_accessor :x, :y, :speed
  
  def initialize
    # Load player animation
    @current_animation = :standing
    @standing = Gosu::Image.new("#{IMAGES_DIR}/pirate/idle_0.png")
    
    ANIMATION_TYPES.each do |type|
      @animation ||= {}
      @animation[type] = {} 
      @animation[type][:frames] = []
      @animation[type][:current_frame] = 0
    end
    
    (0..5).each do |counter|
      @animation[:movement][:frames] << Gosu::Image.new("#{IMAGES_DIR}/pirate/run_#{counter}.png")
      @animation[:attack][:frames] << Gosu::Image.new("#{IMAGES_DIR}/pirate/attack_#{counter}.png") unless counter == 5   
    end 
    
    @x = @y = @var_x = @var_y = 0.0
    
    # Current character direction (1 - right; -1 - left)
    @facing_dir = 1 
    @speed = 3.5     
  end
  
  def warp(x, y)
    @x, @y = x, y
    @var_x, @var_y = x, y
  end

  def move(x = 0, y = 0, facing_dir = @facing_dir)
    if @current_animation != :attack
      current_animation(:movement)
      current_frame(:movement)
    end
    
    @facing_dir = facing_dir
    @x += x
    @y += y
    @x %= 2048
    @y %= 1024
  end
  
  def attack
    return if @current_animation == :movement
    current_animation(:attack)
    current_frame(:attack)
  end
  
  def facing_dir(value)
    case value
    when :left
      @facing_dir = -1
    when :right 
      @facing_dir = 1
    end
  end
  
  def current_animation(animation)
    @current_animation = animation 
  end
  
  def current_frame(animation_type)
    if @animation[animation_type][:current_frame] == @animation[animation_type][:frames].size - 1
      @animation[animation_type][:current_frame] = 0
    else
      return @animation[animation_type][:current_frame] unless frame_expired?
      @animation[animation_type][:current_frame] += 1
    end 
  end
  
  def frame_expired?
    now = Gosu.milliseconds
    @last_frame ||= now

    if (now - @last_frame) > FRAME_DELAY
      @last_frame = now
    end
  end
  
  def draw
    if @var_x == @x && @var_y == @y && @current_animation != :attack
      current_animation(:standing)
    end

    case @current_animation
    when :standing
      @standing.draw_rot(@x, @y, ZOrder::Player, 0, 0.5, 0, @facing_dir)
    when :movement
      frame = @animation[@current_animation][:current_frame]
      @animation[@current_animation][:frames][frame].draw_rot(@x, @y, ZOrder::Player, 0, 0.5, 0, @facing_dir)
      @var_x = @x
      @var_y = @y
    when :attack
      frame = @animation[@current_animation][:current_frame]
      
      @animation[@current_animation][:frames][frame].draw_rot(@x, @y, ZOrder::Player, 0, 0.5, 0, @facing_dir)
      current_animation(:standing)
    end
  end
  
end