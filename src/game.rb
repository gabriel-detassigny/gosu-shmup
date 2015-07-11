require 'gosu'
require './src/player.rb'
require './src/enemy.rb'
require './src/direction.rb'

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
    @enemies = []
    enemy = Enemy.new
    enemy.warp(WIDTH / 2, 100)
    @enemies.push enemy
  end

  def update
    _handle_inputs
    _check_collisions
    @bullets.delete_if do |bullet|
      bullet.move
      bullet.over?
    end
  end

  def draw
    @background.draw 0, 0, 0
    @player.draw
    @enemies.each { |enemy| enemy.draw }
    @bullets.each { |bullet| bullet.draw }
  end

  def button_down key
    if key == Gosu::KbEscape
      close
    end
  end

  private
  def _check_collisions
    @bullets.delete_if do |bullet|
      collision = false
      @enemies.delete_if do |enemy|
        if bullet.collision? enemy
          collision = true
          true
        end
      end
      collision
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
      bullet = @player.fire
      @bullets.push(bullet) unless bullet.nil?
    end
  end
end
