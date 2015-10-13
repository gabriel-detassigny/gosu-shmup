require 'gosu'
require './src/elements/player'
require './src/elements/enemyfleet'
require './src/elements/item'
require './src/direction'
require './src/zorder'
require './src/screens/screen'
require './src/screens/level'
require './src/screens/gameover'
require './src/screens/endlevel'

class GameWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize options = {}
    super WIDTH, HEIGHT, options['fullscreen']
    self.caption = 'Shmup Game'

    player = Player.new options['godmode']
    @screen = Level.new player, 0
  end

  def update
    _handle_inputs
    if @screen.status == Screen::STATUS_OK
      @screen.update
    elsif @screen.status == Screen::STATUS_NEXT
      @screen = @screen.get_next_screen
    elsif @screen.status == Screen::STATUS_OVER
      @screen = @screen.get_game_over
    end
  end

  def draw
    @screen.draw
  end

  private
  def _handle_inputs
    if Gosu::button_down? Gosu::KbEscape
      close
    end
  end
end
