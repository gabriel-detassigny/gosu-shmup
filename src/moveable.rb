class Moveable

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
    if (self.position[0][0] >= other.position[0][0] && self.position[0][1] >= other.position[0][1] \
      && self.position[0][0] <= other.position[1][0] && self.position[0][1] <= other.position[1][1]) \
      || (self.position[1][0] >= other.position[0][0] && self.position[1][1] >= other.position[0][1] \
      && self.position[1][0] <= other.position[1][0] && self.position[1][1] <= other.position[1][1])
      return true
    end
    return false
  end

end
