class Moveable

  def initialize
    @x = 0.0
    @y = 0.0
    @z = 1
    @image = nil
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end
