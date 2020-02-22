module Actions
  module Add
    include Blocks

    def add! # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      with_re_prompt(:add, :another) do
        success = false

        display.clear_screen!

        within_box do
          char = read_button_char_to_add!

          if invalid_add_char?(char)
            next display.new_lines(1).print_from(:add, :invalid_char, color: 'red')
          end

          sound_name = read_button_name!
          sound_path = read_button_sound_path!

          if invalid_sound_path?(sound_path)
            next display.new_lines(1).print_from(:add, :invalid_sound, color: 'red')
          end

          success = true
          copy    = ask_for_copy_confirmation?

          loader.add_button!(char, sound_name, sound_path, copy: copy)
        end

        if success
          display.new_lines(2)
                 .print_from(:add, :success, color: 'green')
        end
      end
    end

    def read_button_char_to_add!
      display.print_from(:add, :step_0, ljust: 0, color: 'cyan')
             .new_lines(1)
             .print_from(:add, :step_1, inline: true)
             .read_char_and_print_it!
    end

    def read_button_name!
      display.new_lines(1)
             .print_from(:add, :step_2, inline: true)
             .read_string!
    end

    def read_button_sound_path!
      display.new_lines(1)
             .print_from(:add, :step_3, inline: true)
             .read_string_with_preloaded!("#{ENV['HOME']}/")
    end

    def ask_for_copy_confirmation?
      display.new_lines(1)
             .print_from(:add, :copy, ljust: 0)
             .read_char_until_confirmation!(ljust: 0)
             .yes?
    end

    def invalid_add_char?(char)
      sound?(char) || Constants::SPECIAL_BUTTONS.include?(char)
    end

    def invalid_sound_path?(path)
      !File.file?(path) || Constants::AUDIO_FORMATS.none? { |format| path.include?(format) }
    end
  end
end
