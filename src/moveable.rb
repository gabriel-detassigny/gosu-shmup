class Moveable
  attr_reader :size

  def initialize
    @x = 0.0
    @y = 0.0
    @z = 1
    @image = nil
    @size = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw(@x, @y, 1)
  end

  def position
    return [[@x, @y], [@x + @size, @y + @size]]
  end

  def collision? other
    if (Gosu::distance(*self.position[0], *other.position[0]) <= other.size \
      && Gosu::distance(*self.position[0], *other.position[1]) <= other.size) \
      || (Gosu::distance(*self.position[1], *other.position[0]) <= other.size \
      && Gosu::distance(*self.position[1], *other.position[1]) <= other.size)
      return true
    end
    return false
  end

end
