module Actions
  module Mute
    def mute!
      @player.mute!(force: true)
      @last_button = nil
    end
  end
end
