require 'perlin_noise'

require './lib/constants.rb'

class Map 
  def initialize
    load_tiles
    @map = generate_map
  end
  
  def draw(camera)
    @map.each do |x, row|
      row.each do |y, val|
        tile = @map[x][y]
        map_x = x * TILE_SIZE
        map_y = y * TILE_SIZE
        pos = CP::Vec2.new(map_x, map_y)
        tile.draw(*camera.x_parallax_world_to_screen(pos, ZOrder::Background + 1).to_a, ZOrder::Background)
      end
    end
  end

  private

  def load_tiles
    @floor_nerves = []
    @floor_vines = []
    @tomb = []
    @pebble_brown = []
    
    (0..10).each do |counter|
      
      if (0..8).include?(counter)
        @pebble_brown << Gosu::Image.new("#{BACKGROUNDS_DIR}/pebble_brown#{counter}.png")
      end
      
      if (0..6).include?(counter)
        @floor_nerves << Gosu::Image.new("#{BACKGROUNDS_DIR}/floor_nerves#{counter}.png")
      end
      
      if (0..2).include?(counter)
        @floor_vines << Gosu::Image.new("#{BACKGROUNDS_DIR}/floor_vines#{counter}.png")
      end
      
      if (0..3).include?(counter)
        @tomb << Gosu::Image.new("#{BACKGROUNDS_DIR}/tomb#{counter}.png")
      end
    end
  end

  def generate_map
    noises = Perlin::Noise.new(2)
    contrast = Perlin::Curve.contrast(
      Perlin::Curve::CUBIC, 2)
    map = {}
    100.times do |x|
      map[x] = {}
      100.times do |y|
        n = noises[x * 0.1, y * 0.1]
        n = contrast.call(n)
        map[x][y] = choose_tile(n)
      end
    end
    map
  end

  def choose_tile(val)
    case val
    when 0.0..0.3 
      @floor_nerves[rand(0..6)]
    when 0.3..0.45
      @pebble_brown[rand(0..8)]
    when 0.45..0.5 
      @tomb[rand(0..3)]
    else # 55% chance
      @floor_vines[rand(0..2)]
    end
  end
end
