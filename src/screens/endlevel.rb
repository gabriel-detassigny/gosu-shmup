class EndLevel < Screen

  SECONDS_DISPLAY = 5

  def initialize player, number
    super(player)
    @number = number
    @time = Gosu::milliseconds / 1000
    @endgame = Configuration.instance.last_level? @number
  end

  def update

  end

  def draw
    font = Gosu::Font.new 40
    title_font = Gosu::Font.new 80
    if @endgame
      title_font.draw("Game finished", GameWindow::WIDTH / 4, GameWindow::HEIGHT / 4, ZOrder::INFO)
    else
      title_font.draw("Level #{@number} finished", GameWindow::WIDTH / 4, GameWindow::HEIGHT / 4, ZOrder::INFO)
    end
    font.draw("Score : #{@player.score}", 320, GameWindow::HEIGHT / 2, ZOrder::INFO)
  end

  def status
    if @endgame
      STATUS_OK
    elsif @time + 5 < Gosu::milliseconds / 1000
      STATUS_NEXT
    else
      STATUS_OK
    end
  end

  def get_next_screen
    Level.new @player, @number + 1
  end
end
