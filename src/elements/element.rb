class Element
  attr_reader :size

  def initialize
    @x = 0.0
    @y = 0.0
    @size = 0
    @image = nil
    @time = Gosu::milliseconds / 40
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw(@x, @y, @z)
  end

  def travel
    if @time < Gosu::milliseconds / 40
        @y += 3
      @time = Gosu::milliseconds / 40
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
