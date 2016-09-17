require './src/elements/element'

class Explosion < Element
  EXPLOSION_TIME = 100

  def initialize animation, position
    super()
    @x = position[0]
    @y = position[1]
    @z = ZOrder::BULLET
    @size = 40
    @animation = animation
    @state = 0
    @animation_time = Gosu::milliseconds / EXPLOSION_TIME
  end

  def draw
    if @state < @animation.size
      @image = @animation[@state]
      super
    end
  end

  def update
    travel
    if @animation_time != Gosu::milliseconds / EXPLOSION_TIME
      @state += 1
      @animation_time = Gosu::milliseconds / EXPLOSION_TIME
    end
  end

  def over?
    @y >= GameWindow::HEIGHT || @state >= @animation.size
  end
end
