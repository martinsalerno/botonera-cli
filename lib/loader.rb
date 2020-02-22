class Loader
  attr_reader :buttons

  def initialize
    @buttons = fetch_buttons!
  end

  def add_button!(char, sound_name, source_path, copy: false)
    source_path = make_copy(source_path) if copy

    @buttons.merge!(
      char => {
        'name' => sound_name[0..Constants::MAX_STRING_SIZE - 1],
        'source' => source_path
      }
    )

    save!
  end

  def remove_button!(char)
    @buttons.delete(char)

    save!
  end

  private

  def save!
    @buttons = buttons.sort.to_h

    File.write(Constants::BUTTONS_FILE_PATH, buttons.to_json)
  end

  def make_copy(source_path)
    sound_name = source_path.split('/').last

    FileUtils.cp(source_path, Constants::SOUNDS_DIR_PATH, preserve: true)

    "#{Constants::SOUNDS_DIR_PATH}/#{sound_name}"
  end

  def fetch_sounds
    Dir.glob("#{Constants::SOUNDS_DIR_PATH}/*")
  end

  def fetch_buttons!
    buttons_json = File.read(Constants::BUTTONS_FILE_PATH)

    JSON.parse(buttons_json)
  end
end
