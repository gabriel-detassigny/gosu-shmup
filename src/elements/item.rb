require './src/elements/element'

class Item < Element
  attr_reader :type
  def initialize position
    super()
    @x = position[0]
    @y = position[1]
    @z = ZOrder::ITEM
    @size = 16

    @type = %w(life missile).sample
    @image = Gosu::Image.new "assets/#{@type}-item.png"
  end

  def over?
    @y >= GameWindow::HEIGHT
  end
end
