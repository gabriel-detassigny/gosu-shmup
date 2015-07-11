require './src/moveable.rb'
require './src/bullet.rb'

class Player < Moveable
  def initialize
    super
    @image = Gosu::Image.new 'assets/spaceship.png'
    @speed = 4.5
    @last_bullet = Gosu::milliseconds / 500
    @size = 48
  end
  
  def fire
    return nil if @last_bullet == Gosu::milliseconds / 500

    bullet = Bullet.new
    bullet.warp @x + 20, @y - 10
    @last_bullet = Gosu::milliseconds / 500
    return bullet
  end
end
