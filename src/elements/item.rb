require './src/elements/element'

class Element
  def initialize player
    @image = Gosu::Image.new 'assets/life-item.png'
    @size = 16
    @z = ZOrder::ITEM
  end
end
