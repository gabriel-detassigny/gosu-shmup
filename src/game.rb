class GameWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Shmup Game'
    @background = Gosu::Image.new 'assets/background.jpg', tileable: true
    @player = Player.new
    @player.warp(WIDTH / 2, HEIGHT - 100)
    @bullets = []
  end

  def update
    _handle_inputs
    @bullets.delete_if do |bullet|
      bullet.move
      bullet.over?
    end
  end

  def draw
    @background.draw 0, 0, 0
    @player.draw
    @bullets.each { |bullet| bullet.draw }
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

    if Gosu::button_down? Gosu::KbSpace
      bullet = @player.fire
      @bullets.push(bullet) unless bullet.nil?
    end
  end
end
