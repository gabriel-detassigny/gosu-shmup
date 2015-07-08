require './src/moveable.rb'
require './src/bullet.rb'

class Player < Moveable
  SHIP_SIZE = 48

  def initialize
    super
    @image = Gosu::Image.new 'assets/spaceship.png'
    @speed = 4.5
  end

  def move_left
    if @x > 0.0
      @x -= @speed
    end
  end

  def move_right
    if @x < GameWindow::WIDTH - SHIP_SIZE
      @x += @speed
    end
  end

  def fire
    bullet = Bullet.new
    bullet.warp @x + 20, @y - 10
    return bullet
  end
end
