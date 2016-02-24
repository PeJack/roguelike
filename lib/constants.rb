SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

WORLD_WIDTH = 1024  
WORLD_HEIGHT = 768

TILE_SIZE = 32

# camera constants
CAMERA_SPEED = 5

# player constants
FRAME_DELAY = 200 # ms
ANIMATION_TYPES = %i(movement attack)
PLAYER_MAX_V = 75.0
ANIM_DIVISOR = 175
JUMP_IMPULSE = 200.0
IN_AIR_X_FORCE = 100.0
ON_GROUND_X_FORCE = 200.0 
SPIN_AROUND_FORCE = 300.0 # force to apply when the player suddenly changes direction
VX_MARGIN_CUT_TO_ZERO = 5.0 # x velocity below which we'll just stop the player moving

# media constants
MEDIA_DIR = "#{File.expand_path("../../", __FILE__)}/media"
IMAGES_DIR = "#{MEDIA_DIR}/images"
SOUNDS_DIR = "#{MEDIA_DIR}/sounds"
MUSIC_DIR = "#{MEDIA_DIR}/music"
BACKGROUNDS_DIR = "#{MEDIA_DIR}/backgrounds"

module ZOrder
  Background, Player = *0..6
end
