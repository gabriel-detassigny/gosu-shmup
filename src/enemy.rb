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
end
