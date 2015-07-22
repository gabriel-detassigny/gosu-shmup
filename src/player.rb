require './src/moveable.rb'
require './src/bullet.rb'
require './src/direction.rb'

class Player < Moveable
  attr_accessor :lives
  def initialize
    super
    @image = Gosu::Image.new 'assets/spaceship.png'
    @speed = 4.5
    @last_bullet = Gosu::milliseconds / 500
    @size = 48
    @lives = 3
    @heart = Gosu::Image.new 'assets/heart.png'
  end

  def draw
    super
    _draw_lives
  end

  def fire
    return nil if @last_bullet == Gosu::milliseconds / 500

    bullet = Bullet.new(true)
    bullet.warp @x + 20, @y - 10
    bullet.orientation = Direction::UP
    @last_bullet = Gosu::milliseconds / 500
    return bullet
  end

  private
  def _draw_lives
    x = 2.0
    y = GameWindow::HEIGHT - 32
    (1..@lives).each do |life|
      @heart.draw(x, y, 1)
      x += 40
    end
  end
end
