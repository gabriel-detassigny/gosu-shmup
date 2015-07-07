require './src/moveable.rb'
require './src/bullet.rb'

class Player < Moveable
  def initialize
    super
    @image = Gosu::Image.new 'assets/spaceship.png'
  end

  def move_left
    if @x > 0.0
      @x -= 4.5
    end
  end

  def move_right
    if @x < GameWindow::WIDTH - 48
      @x += 4.5
    end
  end

  def fire
    bullet = Bullet.new
    bullet.warp @x + 20, @y - 10
    return bullet
  end
end
