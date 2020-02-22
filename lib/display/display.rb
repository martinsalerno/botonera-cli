class Display
  COLORS = JSON.parse(File.read("#{__dir__}/data/colors.json"))
  TEXT   = JSON.parse(File.read("#{__dir__}/data/texts.json"), symbolize_names: true)[:es]

  DEFAULT_COLOR  = 'white'.freeze
  HIGHLIGH_COLOR = 'green'.freeze

  NEW_LINE      = "\n".freeze
  BOX_DELIMITER = '-'.freeze

  def print_botonera!(buttons, highlight_button, single_mode) # rubocop:disable Metrics/AbcSize
    box(header: true) do
      buttons.each do |key, button|
        color = highlight_button == key ? HIGHLIGH_COLOR : DEFAULT_COLOR

        printf(format(TEXT.dig(:home, :button), key, button['name']), color: color)
      end
    end

    color = single_mode ? DEFAULT_COLOR : HIGHLIGH_COLOR
    printf(TEXT.dig(:home, :single_mode)[single_mode.to_s.to_sym], color: color, ljust: 0)
    printf(generate(NEW_LINE, 3))

    printf(TEXT.dig(:home, :add)    % Constants::ADD)
    printf(TEXT.dig(:home, :remove) % Constants::REMOVE)
    printf(TEXT.dig(:home, :switch) % Constants::SWITCH)
    printf(TEXT.dig(:home, :quit)   % Constants::QUIT)
  end

  def print_from(*targets, **options)
    text = TEXT.dig(*targets)
    text = text % options[:data] if options[:data]

    printf(text, **options)
  end

  def new_lines(amount = 1)
    printf(generate(NEW_LINE, amount))
  end

  def clear_screen!
    printf(Constants::CLEAR_SCREEN)
  end

  def read_char!
    Input.new(STDIN.getch)
  end

  def read_string!
    Input.new(STDIN.gets.strip)
  end

  def read_string_with_preloaded!(text)
    Readline.pre_input_hook = lambda {
      Readline.insert_text(text)
      Readline.redisplay
      Readline.pre_input_hook = nil
    }

    Readline.readline(' ')
  end

  def read_char_and_print_it!
    read_char!.tap do |char|
      print("#{char}\n")
    end
  end

  def read_char_until_confirmation!(**options)
    print_yes_no!(**options)

    read_char_until_in_options!([Constants::YES, Constants::NO])
  end

  def box(header: false)
    printf(generate(NEW_LINE, Constants::HEIGHT_OFFSET))
    printf(TEXT.dig(:home, :header), ljust: 0, color: HIGHLIGH_COLOR) if header
    printf(generate(BOX_DELIMITER, Constants::BOX_SIZE), ljust: 0)
    printf(generate(NEW_LINE, 2))

    yield

    printf(generate(NEW_LINE, 2))
    printf(generate(BOX_DELIMITER, Constants::BOX_SIZE), ljust: 0)
  end

  private

  def printf(text, **options)
    inline = options[:inline] || false
    color  = options[:color]  || DEFAULT_COLOR

    text = text.ljust(options[:ljust] || Constants::BOX_SIZE)
    text = text.rjust(options[:rjust] || 0)
    text = "\e#{COLORS[color]}#{text}".center(Constants::SCREEN_WIDTH)

    if inline
      print("#{text.rstrip} ")
    else
      puts(text)
    end

    self
  end

  def print_yes_no!(**options)
    printf(TEXT.dig(:yes) % Constants::YES, **options)
    printf(TEXT.dig(:no)  % Constants::NO, **options)
  end

  def read_char_until_in_options!(options, char = nil)
    return char if options.include?(char)

    read_char_until_in_options!(options, read_char!)
  end

  def generate(string, amount = 1)
    string * amount
  end
end
