require './src/enemy.rb'

class EnemyFleet
  def initialize
    @enemies = []
    _add_enemy
  end

  def draw
    @enemies.each(&:draw)
  end

  def update
    @enemies.each(&:travel)
  end

  def collision? moveable
    clear = @enemies.reject! {|enemy| moveable.collision? enemy }
    clear != nil
  end

  private
  def _add_enemy
    enemy = Enemy.new
    enemy.warp(GameWindow::WIDTH / 2, 100)
    @enemies.push enemy
  end
end
