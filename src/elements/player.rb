require './src/elements/moveable'
require './src/elements/bullet'
require './src/direction'
require './src/elements/item'
require './src/elements/explosion'

class Player < Moveable
  attr_accessor :score
  attr_reader :lives

  MAX_LIVES = 5
  MAX_CANONS = 3
  TIME_DIVIDER = 350

  def initialize godmode
    super()
    @godmode = godmode
    @image = Gosu::Image.new 'assets/images/spaceships/player.png'
    @speed = 4.5
    @last_bullet = Gosu::milliseconds / TIME_DIVIDER
    @size = 48
    @lives = 3
    @heart = Gosu::Image.new 'assets/images/elements/heart.png'
    @score = 0
    @font = Gosu::Font.new 20
    @animation = 0
    @z = ZOrder::SHIP
    @canons = 1
    @explosion = nil
  end

  def draw
    if @explosion.nil?
      if @animation % 2 == 0
        super
      end
    else
      @explosion.draw
    end
    _draw_lives
    _draw_score
  end

  def update
    @animation -= 1 if @animation > 0
    @explosion.update unless @explosion.nil?
  end

  def remove_life
    if @animation == 0 && !@godmode
      @lives -= 1
      if @lives <= 0
        create_explosion
      else
        @animation = 100
      end
      @canons = 1
    end
  end

  def over?
    @lives <= 0 && !@explosion.nil? && @explosion.over?
  end

  def fire
    return nil if @last_bullet == Gosu::milliseconds / TIME_DIVIDER
    bullets = _extra_canons
    bullet = Bullet.new(true)
    bullet.warp @x + 20, @y - 10
    bullet.orientation = Direction::UP
    @last_bullet = Gosu::milliseconds / TIME_DIVIDER
    bullets.push bullet
    return bullets
  end

  def get_item item
    if item.type == 'life'
      @lives += 1 if @lives < MAX_LIVES
    elsif item.type == 'missile'
      @canons += 1 if @canons < MAX_CANONS
    end
  end

  private
  def _extra_canons
    bullets = []
    if @canons > 1
      bullet = Bullet.new(true)
      bullet.warp @x, @y - 10
      bullet.orientation = Direction::UP
      bullets.push bullet
    end
    if @canons > 2
      bullet = Bullet.new(true)
      bullet.warp @x + 40, @y - 10
      bullet.orientation = Direction::UP
      bullets.push bullet
    end
    return bullets
  end

  def _draw_lives
    x = 2.0
    y = GameWindow::HEIGHT - 32
    (1..@lives).each do |life|
      @heart.draw(x, y, ZOrder::INFO)
      x += 40
    end
  end

  def _draw_score
    score_size = @score.to_s.size + 1
    @font.draw("#{@score}", GameWindow::WIDTH - (10 * score_size), GameWindow::HEIGHT - 25, ZOrder::INFO)
  end

  def create_explosion
    explosion_animation = Gosu::Image::load_tiles("assets/images/elements/explosion.png", 40, 40)
    @explosion = Explosion.new explosion_animation, [@x, @y]
  end
end
