class Botonera
  include Actions::Add
  include Actions::Remove
  include Actions::Mute
  include Actions::Switch

  attr_reader :loader, :player, :display, :single_mode, :last_button

  def initialize
    @loader  = Loader.new
    @player  = Player.new(self)
    @display = Display.new

    @single_mode = true
    @last_button = nil
  end

  def start! # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    puts Constants::SWITCH_TO_ALTERNATIVE_SCREEN

    loop do
      button_char = display.clear_screen!
                           .print_botonera!(buttons, last_button, single_mode)
                           .read_char!

      next trigger_sound!(button_char) if sound?(button_char)

      case button_char
      when Constants::ADD    then add!
      when Constants::REMOVE then remove!
      when Constants::QUIT   then break quit!
      when Constants::QUIT_2 then break quit!
      when Constants::MUTE   then mute!
      when Constants::SWITCH then switch!
      end
    end
  end

  def quit!(error = nil)
    puts Constants::SWITCH_TO_ORIGINAL_SCREEN

    if error
      puts error.inspect
      puts error
      puts error.backtrace
    end

    player.mute!(force: true)
  end

  private

  def trigger_sound!(button_char)
    button = buttons[button_char]

    player.play(button['source'])

    @last_button = button_char
  end

  def buttons
    loader.buttons
  end

  def sound?(button_char)
    !buttons[button_char].nil?
  end
end
