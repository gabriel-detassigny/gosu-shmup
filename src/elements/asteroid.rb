require './src/elements/moveable'

class Asteroid < Moveable
  attr_reader :type
  def initialize
    super()
    @z = ZOrder::ASTEROID
    @size = 64
    @speed = 5
    @image = Gosu::Image.new "assets/asteroid.png"
  end

  def over?
    @y >= GameWindow::HEIGHT
  end
end
