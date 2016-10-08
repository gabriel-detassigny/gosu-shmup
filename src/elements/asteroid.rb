require './src/elements/moveable'

class Asteroid < Moveable
  attr_reader :type
  def initialize
    super()
    @z = ZOrder::ASTEROID
    @size = 64
    @speed = 5
    @image = Gosu::Image.new "assets/images/elements/asteroid.png"
    @resistance = 5
  end

  def over?
    @y >= GameWindow::HEIGHT
  end

  def decrease_resistance!
    @resistance -= 1
  end

  def destroyed?
    @resistance <= 0
  end
end
