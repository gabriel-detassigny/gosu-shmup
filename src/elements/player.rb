require './src/elements/moveable'
require './src/elements/bullet'
require './src/direction'

class Player < Moveable
  attr_accessor :score
  attr_reader :lives

  def initialize
    super
    @image = Gosu::Image.new 'assets/spaceship.png'
    @speed = 4.5
    @last_bullet = Gosu::milliseconds / 500
    @size = 48
    @lives = 3
    @heart = Gosu::Image.new 'assets/heart.png'
    @score = 0
    @font = Gosu::Font.new 20
    @animation = 0
    @z = ZOrder::SHIP
  end

  def draw
    if @animation % 2 == 0
      super
    end
    _draw_lives
    _draw_score
  end

  def update
    @animation -= 1 if @animation > 0
  end

  def remove_life
    if @animation == 0
      @lives -= 1
      @animation = 100
    end
  end

  def fire
    return nil if @last_bullet == Gosu::milliseconds / 350

    bullet = Bullet.new(true)
    bullet.warp @x + 20, @y - 10
    bullet.orientation = Direction::UP
    @last_bullet = Gosu::milliseconds / 350
    return bullet
  end

  private
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
end
