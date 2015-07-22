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
  end

  def fire
    return nil if @last_bullet == Gosu::milliseconds / 500

    bullet = Bullet.new(true)
    bullet.warp @x + 20, @y - 10
    bullet.orientation = Direction::UP
    @last_bullet = Gosu::milliseconds / 500
    return bullet
  end
end
