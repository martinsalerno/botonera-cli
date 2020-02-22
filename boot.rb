require 'json'
require 'fileutils'
require 'stringio'
require 'io/console'
require 'concurrent'

module SuppresOutput
  def suppress_output!
    original = $stderr
    $stderr = StringIO.new
    yield
    $stderr.string
  rescue StandardError
    sleep(0.5)
  ensure
    $stderr = original
  end
end

require_relative 'constants'
require_relative 'lib/display/input'
require_relative 'lib/display/display'
require_relative 'lib/loader'
require_relative 'lib/player'
require_relative 'lib/sound'
require_relative 'lib/botonera/actions/blocks'
require_relative 'lib/botonera/actions/special_buttons/add'
require_relative 'lib/botonera/actions/special_buttons/remove'
require_relative 'lib/botonera/actions/special_buttons/mute'
require_relative 'lib/botonera/actions/special_buttons/switch'
require_relative 'lib/botonera/botonera'

def setup!
  Dir.mkdir(Constants::BOTONERA_DIR_PATH) unless Dir.exist?(Constants::BOTONERA_DIR_PATH)
  Dir.mkdir(Constants::SOUNDS_DIR_PATH)   unless Dir.exist?(Constants::SOUNDS_DIR_PATH)

  File.open(Constants::BUTTONS_FILE_PATH, 'a+') do |file|
    content = file.read

    file.puts('{}') if content.empty?
  end
end
