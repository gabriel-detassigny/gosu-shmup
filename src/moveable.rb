require './src/direction.rb'

class Moveable
  attr_accessor :orientation
  attr_reader :size

  def initialize
    @x = 0.0
    @y = 0.0
    @z = 2
    @image = nil
    @size = 0
    @speed = 1
    @orientation = Direction::DOWN
    @time = Gosu::milliseconds / 100
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw(@x, @y, @z)
  end

  def travel
    if @time < Gosu::milliseconds / 40
      if @orientation == Direction::UP
        @y -= @speed
      elsif @orientation == Direction::DOWN
        @y += @speed
      end
      @time = Gosu::milliseconds / 40
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

  def position
    return [[@x, @y], [@x + @size, @y + @size]]
  end

  def collision? other, recursion = true
    if (Gosu::distance(*self.position[0], *other.position[0]) <= other.size \
      && Gosu::distance(*self.position[0], *other.position[1]) <= other.size) \
      || (Gosu::distance(*self.position[1], *other.position[0]) <= other.size \
      && Gosu::distance(*self.position[1], *other.position[1]) <= other.size) \
      || (recursion && other.collision?(self, false))
      return true
    end
    return false
  end

end
