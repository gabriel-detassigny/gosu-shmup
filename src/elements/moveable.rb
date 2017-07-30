require './src/direction'
require './src/zorder'
require './src/elements/element'

class Moveable < Element
  attr_accessor :orientation

  DIAGONAL_COEFF = 0.707

  def initialize
    super
    @speed = 1
    @orientation = Direction::DOWN
  end

  def travel
    if @time < Gosu::milliseconds / Element::TIME_DIVIDER
      if @orientation == Direction::UP
        @y -= @speed
      elsif @orientation == Direction::DOWN
        @y += @speed
      elsif @orientation == Direction::LEFT_DOWN
        @y += (@speed * DIAGONAL_COEFF)
        @x -= (@speed * DIAGONAL_COEFF)
      elsif @orientation == Direction::RIGHT_DOWN
        @y += (@speed * DIAGONAL_COEFF)
        @x += (@speed * DIAGONAL_COEFF)
      end
      @time = Gosu::milliseconds / Element::TIME_DIVIDER
    end
  end

  def move direction
    case direction
    when Direction::LEFT
      if @x > 0.0
        @x -= @speed
      end
    when Direction::RIGHT
      if @x < GameWindow::WIDTH - @size
        @x += @speed
      end
    when Direction::UP
      if @y > 0.0
        @y -= @speed
      end
    when Direction::DOWN
      if @y < GameWindow::HEIGHT - @size
        @y += @speed
      end
    end
  end
end
