require './src/screens/gameover'
require './src/screens/endlevel'
require './src/direction'
require './src/elements/asteroid'
require './src/elements/explosion'

class Level < Screen
  TIME_DIVIDER = 80

  def initialize player, number
    super(player)
    @player.warp(GameWindow::WIDTH / 2, GameWindow::HEIGHT - 100)
    @number = number
    @config = Configuration.instance.get_level @number
    @background = Gosu::Image.new "assets/images/backgrounds/#{@config['background']}", tileable: true
    @time = Gosu::milliseconds / TIME_DIVIDER
    @explosion_animation = Gosu::Image::load_tiles("assets/explosion.png", 40, 40)
    init_elements
  end

  def init_elements
    @bullets = []
    @items = []
    @asteroids = []
    @explosions = []
    @fleet = EnemyFleet.new @config['enemies']
  end

  def update
    _handle_inputs

    @player.update
    @fleet.update

    _update_asteroids
    _update_bullets

    @items.each(&:travel)
    @items.reject!(&:over?)

    @explosions.each(&:update)
    @explosions.reject!(&:over?)
  end

  def draw
    @background.draw 0, 0, ZOrder::BACKGROUND
    @player.draw
    @fleet.draw
    @bullets.each(&:draw)
    @items.each(&:draw)
    @asteroids.each(&:draw)
    @explosions.each(&:draw)
  end

  def status
    if @player.lives <= 0
      STATUS_OVER
    elsif @fleet.down?
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
        @explosions.push Explosion.new(@explosion_animation, bullet.position[0])
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

    @asteroids.each do |asteroid|
      @player.remove_life if asteroid.collision? @player
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

  def _update_asteroids
    if @time != Gosu::milliseconds / TIME_DIVIDER
      if rand(1..40) == 40
        _add_asteroid
      end
      @time = Gosu::milliseconds / TIME_DIVIDER
    end
    @asteroids.each(&:travel)
    @asteroids.reject!(&:over?)
  end

  def _update_bullets
    @bullets.concat @fleet.get_bullets
    _check_collisions
    @bullets.reject! do |bullet|
      bullet.travel
      bullet.over?
    end
  end

  def _add_asteroid
    asteroid = Asteroid.new
    width = rand(0..(GameWindow::WIDTH - asteroid.size))
    asteroid.warp(width, 0.0)
    @asteroids.push asteroid
  end
end
