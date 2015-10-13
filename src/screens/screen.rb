class Screen
  attr_reader :player

  STATUS_OK = 0
  STATUS_OVER = 1
  STATUS_NEXT = 2

  def initialize player
    @player = player
  end

  def update
    @player.update
  end

  def draw
    @player.draw
  end

  def status
    STATUS_OK
  end

  def get_game_over
    GameOver.new @player
  end

  def get_next_screen
    raise 'abstract method not implemented'
  end
end
