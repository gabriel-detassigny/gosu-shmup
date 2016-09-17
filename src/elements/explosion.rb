require './src/elements/element'

class Explosion < Element
  TIME_DIVIDER = 800

  def initialize animation, position
    @x = position[0]
    @y = position[1]
    @z = ZOrder::BULLET
    @size = 40
    @animation = animation
    @state = 0
    @time = Gosu::milliseconds / TIME_DIVIDER
  end

  def draw
    if @state < @animation.size
      @image = @animation[@state]
      super
    end
  end

  def update
    if @time != Gosu::milliseconds / TIME_DIVIDER
      @state += 1
    end
  end

  def over?
    @y >= GameWindow::HEIGHT || @state >= @animation.size
  end
end
