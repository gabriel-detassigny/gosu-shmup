require './src/enemy.rb'

class EnemyFleet
  def initialize
    @enemies = []
    @time = Gosu::milliseconds / 500
  end

  def draw
    @enemies.each(&:draw)
  end

  def update
    _random_ai
    @enemies.each(&:travel)
    @enemies.reject!(&:over?)
  end

  def collision? moveable
    clear = @enemies.reject! {|enemy| moveable.collision? enemy }
    clear != nil
  end

  private
  def _add_enemy
    enemy = Enemy.new
    width = rand(0..(GameWindow::WIDTH - enemy.size))
    enemy.warp(width, 0.0)
    @enemies.push enemy
  end

  def _random_ai
    if @time != Gosu::milliseconds / 500
      if rand(1..5) == 1
        _add_enemy
      end
      @time = Gosu::milliseconds / 500
    end
  end
end
