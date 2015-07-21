require './src/moveable.rb'

class Enemy < Moveable
  def initialize
    super
    @image = Gosu::Image.new 'assets/enemy.gif'
    @size = 32
    @speed = 3
  end

  def over?
    @y >= GameWindow::HEIGHT
  end

  def fire
    bullet = Bullet.new
    bullet.warp @x + 15, @y + 35
    bullet.orientation = Direction::DOWN
    bullet
  end
end
