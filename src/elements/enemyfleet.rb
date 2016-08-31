require './src/elements/enemy'

class EnemyFleet
  TIME_DIVIDER = 80

  def initialize config
    @enemies = []
    @time = Gosu::milliseconds / TIME_DIVIDER
    @bullets = []
    @config = config
  end

  def draw
    @enemies.each(&:draw)
  end

  def update
    _random_ai
    @enemies.each(&:travel)
    @enemies.reject!(&:over?)
  end

  def get_bullets
    @bullets.pop(@bullets.count)
  end

  def size
    @config.values.reduce(&:+)
  end

  def collision? moveable
    clear = @enemies.reject! {|enemy| moveable.collision? enemy }
    clear != nil
  end

  def down?
    return (size <= 0 && @enemies.empty?)
  end

  private
  def _add_enemy
    random_key = @config.reject {|enemy, size| size == 0 }.keys.sample
    @config[random_key] -= 1
    enemy = Enemy.new random_key
    width = rand(0..(GameWindow::WIDTH - enemy.size))
    enemy.warp(width, 0.0)
    @enemies.push enemy
  end

  def _random_ai
    if @time != Gosu::milliseconds / TIME_DIVIDER
      if rand(1..25) == 25 && size > 0
        _add_enemy
      end
      @time = Gosu::milliseconds / TIME_DIVIDER
      @enemies.each do |enemy|
        if rand((enemy.hostility)..15) == 15
          @bullets.push enemy.fire
        end
        if rand(0..10) == 10
          enemy.random_destination
        end
      end
    end
  end

end
