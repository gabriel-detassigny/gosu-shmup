require './src/screens/screen'

class GameOver < Screen

  def update

  end

  def draw
    font = Gosu::Font.new 40
    title_font = Gosu::Font.new 80
    title_font.draw("GAME OVER", GameWindow::WIDTH / 4, GameWindow::HEIGHT / 4, ZOrder::INFO)
    font.draw("Score : #{@player.score}", 320, GameWindow::HEIGHT / 2, ZOrder::INFO)
  end
end
