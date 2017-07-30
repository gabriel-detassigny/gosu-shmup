class Bullet < Moveable
  def initialize(player_fired)
    super()
    @image = Gosu::Image.new 'assets/images/elements/bullet.bmp'
    @size = 9
    @speed = 11
    @player_fired = player_fired
    @z = ZOrder::BULLET
  end

  def fired_by_player?
    @player_fired
  end

  def over?
    @y <= 0.0 || @y >= GameWindow::HEIGHT || @x < 0 || @x + @size > GameWindow::WIDTH
  end
end
