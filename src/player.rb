class Player
  def initialize
    @image = Gosu::Image.new 'assets/spaceship.png'
    @x = @y = 0.0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move_left
    if @x > 0.0
      @x -= 4.5
    end
  end

  def move_right
    if @x < GameWindow::WIDTH - 48
      @x += 4.5
    end
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end
