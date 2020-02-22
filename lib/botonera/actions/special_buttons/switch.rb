module Actions
  module Switch
    def switch!
      @single_mode = !@single_mode
    end

    def single_mode?
      @single_mode
    end

    def free_mode?
      !single_mode?
    end
  end
end
