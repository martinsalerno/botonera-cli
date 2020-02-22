class Constants
  BOTONERA_DIR_PATH = "#{ENV['HOME']}/.botonera".freeze
  SOUNDS_DIR_PATH   = "#{BOTONERA_DIR_PATH}/sounds".freeze
  BUTTONS_FILE_PATH = "#{BOTONERA_DIR_PATH}/buttons.json".freeze

  ADD    = '+'.freeze
  REMOVE = '-'.freeze
  QUIT   = 'q'.freeze
  QUIT_2 = 'Q'.freeze
  MUTE   = ' '.freeze
  SWITCH = '.'.freeze

  SPECIAL_BUTTONS = [ADD, REMOVE, QUIT, QUIT_2, MUTE, SWITCH].freeze

  YES = 'y'.freeze
  NO  = 'n'.freeze

  CLEAR_SCREEN                 = "\e[H\e[2J".freeze
  SWITCH_TO_ORIGINAL_SCREEN    = "\e[?1049l".freeze
  SWITCH_TO_ALTERNATIVE_SCREEN = "\e[?1049h".freeze

  AUDIO_FORMATS = ['.mp3', '.wav'].freeze

  MAX_STRING_SIZE = 60

  SCREEN_HEIGHT, SCREEN_WIDTH = $stdout.winsize
  HEIGHT_OFFSET               = SCREEN_HEIGHT >= 24 ? SCREEN_HEIGHT / 8 : 0
  BOX_SIZE                    = Constants::SCREEN_WIDTH * 0.6
end
