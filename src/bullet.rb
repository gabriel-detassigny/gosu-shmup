class Bullet < Moveable
  def initialize
    super
    @image = Gosu::Image.new 'assets/bullet.bmp'
    @time = Gosu::milliseconds / 100
    @size = 9
  end

  def over?
    @y <= 0.0
  end

end
