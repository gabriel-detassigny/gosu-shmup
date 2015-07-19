require './src/enemy.rb'

class EnemyFleet
  def initialize
    @enemies = []
    _add_enemy
  end

  def draw
    @enemies.each { |enemy| enemy.draw }
  end

  def update
    @enemies.each { |enemy| enemy.travel }
  end

  def collision? moveable
    collision = false
    @enemies.delete_if do |enemy|
      if moveable.collision? enemy
        collision = true
        true
      end
    end
    collision
  end

  private
  def _add_enemy
    enemy = Enemy.new
    enemy.warp(GameWindow::WIDTH / 2, 100)
    @enemies.push enemy
  end
end
