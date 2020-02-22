require_relative 'boot'

setup!
botonera = Botonera.new

begin
  botonera.start!
rescue StandardError => e
  botonera.quit!(e)
end
