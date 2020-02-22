class Player
  include SuppresOutput

  def initialize(botonera)
    @botonera   = botonera
    @sound_path = ''
  end

  def play(sound_path, **_extra)
    stop_previous_sounds!
    save_sound_path!(sound_path)

    Sound.new(self).async.play(sound_path)
  end

  def mute!(force: false)
    stop_previous_sounds!(force)
  end

  private

  def save_sound_path!(sound_path)
    @sound_path = sound_path
  end

  def stop_previous_sounds!(force = false)
    return unless force || @botonera.single_mode?

    suppress_output! do
      pids = parse_pids(force ? '' : @sound_path)

      return if pids.empty?

      spawn("kill -9 #{pids.join(' ')}")
    end
  end

  def parse_pids(sound_path)
    ps_lines = `ps -o pid,command -a | grep play`.lines.select { |f| f.include?(sound_path) }

    ps_lines.flat_map { |pid| pid.scan(/(\d+)/).first.first.to_i }.flatten
  end
end
