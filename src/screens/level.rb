require './src/screens/gameover'
require './src/screens/endlevel'
require './src/direction'

class Level < Screen
  def initialize player, number
    super(player)
    @player.warp(GameWindow::WIDTH / 2, GameWindow::HEIGHT - 100)
    @number = number
    @config = Configuration.instance.get_level @number
    @background = Gosu::Image.new "assets/#{@config['background']}", tileable: true
    @fleet = EnemyFleet.new
    @bullets = []
    @items = []
  end

  def update
    _handle_inputs
    @player.update
    @fleet.update
    @bullets.concat @fleet.get_bullets
    _check_collisions
    @bullets.reject! do |bullet|
      bullet.travel
      bullet.over?
    end
    @items.each(&:travel)
    @items.reject!(&:over?)
  end

  def draw
    @background.draw 0, 0, ZOrder::BACKGROUND
    @player.draw
    @fleet.draw
    @bullets.each(&:draw)
    @items.each(&:draw)
  end

  def status
    if @player.lives <= 0
      STATUS_OVER
    elsif @config['enemies'] <= @fleet.nbr_of_dead
      STATUS_NEXT
    else
      STATUS_OK
    end
  end

  def get_next_screen
    EndLevel.new @player, @number
  end

  private
  def _check_collisions
    @bullets.reject! do |bullet|
      if bullet.fired_by_player? && @fleet.collision?(bullet)
        @player.score += 5
        if rand(0..10) == 0
          item = Item.new bullet.position[0]
          @items.push item
        end
        true
      elsif !bullet.fired_by_player? && @player.collision?(bullet)
        @player.remove_life
        true
      end
    end
    if @fleet.collision?(@player)
      @player.remove_life
    end
    @items.reject! do |item|
      if item.collision? @player
        @player.get_item item
        true
      end
    end
  end

  def _handle_inputs
    if Gosu::button_down? Gosu::KbLeft
      @player.move Direction::LEFT
    elsif Gosu::button_down? Gosu::KbRight
      @player.move Direction::RIGHT
    end

    if Gosu::button_down? Gosu::KbDown
      @player.move Direction::DOWN
    elsif Gosu::button_down? Gosu::KbUp
      @player.move Direction::UP
    end

    if Gosu::button_down? Gosu::KbSpace
      bullets = @player.fire
      @bullets.push(bullets).flatten! unless bullets.nil?
    end
  end
end
