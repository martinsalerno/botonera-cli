module Actions
  module Blocks
    def with_re_prompt(*display_targets, &block)
      block.call

      confirmation = display.new_lines(2)
                            .print_from(*display_targets, ljust: 0)
                            .new_lines(1)
                            .read_char_until_confirmation!(ljust: 0)
                            .yes?

      with_re_prompt(*display_targets, &block) if confirmation
    end

    def within_box
      display.box do
        yield
      end
    end
  end
end
