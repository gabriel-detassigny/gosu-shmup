require 'gosu'
require './src/player'
require './src/enemyfleet'
require './src/direction'
require './src/zorder'

class GameWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize options = {}
    super WIDTH, HEIGHT, options['fullscreen']
    self.caption = 'Shmup Game'
    @background = Gosu::Image.new 'assets/background.png', tileable: true
    @player = Player.new
    @player.warp(WIDTH / 2, HEIGHT - 100)
    @bullets = []
    @fleet = EnemyFleet.new
  end

  def update
    _handle_inputs
    if @player.lives > 0
      @player.update
      @fleet.update
      @bullets.concat @fleet.get_bullets
      _check_collisions
      @bullets.reject! do |bullet|
        bullet.travel
        bullet.over?
      end
    end
  end

  def draw
    @background.draw 0, 0, ZOrder::BACKGROUND
    if @player.lives > 0
      @player.draw
      @fleet.draw
      @bullets.each(&:draw)
    else
      font = Gosu::Font.new 40
      title_font = Gosu::Font.new 80
      title_font.draw("GAME OVER", WIDTH / 4, HEIGHT / 4, ZOrder::INFO)
      font.draw("Score : #{@player.score}", 320, HEIGHT / 2, ZOrder::INFO)
    end
  end

  private
  def _check_collisions
    @bullets.reject! do |bullet|
      if bullet.fired_by_player? && @fleet.collision?(bullet)
        @player.score += 5 if bullet.fired_by_player?
        true
      elsif !bullet.fired_by_player? && @player.collision?(bullet)
        @player.remove_life
        true
      end
    end
    if @fleet.collision?(@player)
      @player.remove_life
    end
  end

  def _handle_inputs
    if Gosu::button_down? Gosu::KbEscape
      close
    end

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
      bullet = @player.fire
      @bullets.push(bullet) unless bullet.nil?
    end
  end
end
