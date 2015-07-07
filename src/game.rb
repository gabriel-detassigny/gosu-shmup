class GameWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Shmup Game'
    @background = Gosu::Image.new 'assets/background.jpg', tileable: true
    @player = Player.new
    @player.warp(WIDTH / 2, HEIGHT - 100)
  end

  def update
    _handle_inputs
  end

  def draw
    @background.draw 0, 0, 0
    @player.draw
  end

  def button_down key
    if key == Gosu::KbEscape
      close
    end
  end

  private
  def _handle_inputs
    if Gosu::button_down? Gosu::KbLeft
      @player.move_left
    elsif Gosu::button_down? Gosu::KbRight
      @player.move_right
    end
  end
end
