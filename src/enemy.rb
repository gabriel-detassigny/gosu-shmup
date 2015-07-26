require './src/moveable'

class Enemy < Moveable
  def initialize
    super
    @image = Gosu::Image.new 'assets/enemy.gif'
    @size = 32
    @speed = 3
    random_destination
  end

  def over?
    @y >= GameWindow::HEIGHT
  end

  def fire
    bullet = Bullet.new(false)
    bullet.warp @x + 15, @y + 35
    bullet.orientation = Direction::DOWN
    bullet
  end

  def travel
    super
    if @destination + @speed < @x
      move Direction::LEFT
    elsif @destination - @speed > @x
      move Direction::RIGHT
    end
    random_destination if rand(0..15) == 0
  end

  def random_destination
    @destination = rand(0..(GameWindow::WIDTH - @size))
  end
end
