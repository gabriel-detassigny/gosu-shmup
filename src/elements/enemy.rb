require './src/elements/moveable'

class Enemy < Moveable
  attr_reader :hostility

  def initialize config_key
    super()
    config = Configuration.instance.get_enemy config_key
    @image = Gosu::Image.new "assets/images/spaceships/#{config['image']}"
    @size = config['size']
    @speed = config['speed']
    @hostility = config['hostility']
    @life = config['resistance']
    random_destination
    @z = ZOrder::SHIP
  end

  def over?
    @y >= GameWindow::HEIGHT
  end

  def decrease_life
    @life -= 1
  end

  def dead?
    @life <= 0
  end

  def fire
    bullet = Bullet.new(false)
    bullet.warp @x + 15, @y + 35
    bullet.orientation = Direction::DOWN
    bullet
  end

  def travel
    super
    if @destination + @speed < @x
      move Direction::LEFT
    elsif @destination - @speed > @x
      move Direction::RIGHT
    end
  end

  def random_destination
    @destination = rand(0..(GameWindow::WIDTH - @size))
  end
end
