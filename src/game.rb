require 'gosu'
require './src/player.rb'
require './src/enemyfleet.rb'
require './src/direction.rb'

class GameWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Shmup Game'
    @background = Gosu::Image.new 'assets/background.png', tileable: true
    @player = Player.new
    @player.warp(WIDTH / 2, HEIGHT - 100)
    @bullets = []
    @fleet = EnemyFleet.new
  end

  def update
    _handle_inputs
    @fleet.update
    @bullets.concat @fleet.get_bullets
    _check_collisions
    @bullets.reject! do |bullet|
      bullet.travel
      bullet.over?
    end
  end

  def draw
    @background.draw 0, 0, 0
    @player.draw
    @fleet.draw
    @bullets.each(&:draw)
  end

  private
  def _check_collisions
    @bullets.reject! do |bullet|
      if @fleet.collision?(bullet)
        true
      elsif (!bullet.fired_by_player? && @player.collision?(bullet))
        @player.lives -= 1
        if @player.lives == 0
          close
        end
        true
      end
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
