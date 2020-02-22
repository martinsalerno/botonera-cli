module Actions
  module Remove
    include Blocks

    def remove! # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      with_re_prompt(:remove, :another) do
        success = false

        display.clear_screen!

        within_box do
          char = read_button_char_to_remove!

          if invalid_remove?(char)
            next display.new_lines(1).print_from(:remove, :invalid_char, color: 'red')
          end

          removal_confirmed = ask_for_removal_confirmation?(char)

          if removal_confirmed
            loader.remove_button!(char)

            success = true
          end
        end

        if success
          display.new_lines(2)
                 .print_from(:remove, :success, color: 'green')
        end
      end
    end

    def read_button_char_to_remove!
      display.print_from(:remove, :step_0, ljust: 0, color: 'cyan')
             .new_lines(1)
             .print_from(:remove, :step_1, inline: true)
             .read_char_and_print_it!
    end

    def ask_for_removal_confirmation?(char)
      display.new_lines(1)
             .print_from(:remove, :step_2, data: [char, buttons[char]['name']], color: 'red')
             .read_char_until_confirmation!
             .yes?
    end

    def invalid_remove?(char)
      !sound?(char) || Constants::SPECIAL_BUTTONS.include?(char)
    end
  end
end
