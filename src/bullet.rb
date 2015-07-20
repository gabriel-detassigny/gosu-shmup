class Bullet < Moveable
  def initialize
    super
    @image = Gosu::Image.new 'assets/bullet.bmp'
    @size = 9
    @speed = 8
  end

  def over?
    @y <= 0.0 || @y >= GameWindow::HEIGHT
  end

end
