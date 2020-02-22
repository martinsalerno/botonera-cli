class Sound
  include Concurrent::Async
  include SuppresOutput

  def initialize(player)
    super()

    @player = player
  end

  def play(audio_path)
    suppress_output! do
      system("play -V0 -q #{audio_path}")
    end

    @player.finish_sound!
  end
end
