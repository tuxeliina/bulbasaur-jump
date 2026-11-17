require "gosu"

class Game < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "Bulbasaur Jump"
    @bulbasaurs = Gosu::Image.load_tiles("media/img/bulbasaur-jumping-2.png", 256, 256, tileable: true)
    @bulbasaur = @bulbasaurs[0..10]
    @standing_bulbasaur = @bulbasaurs[0..2]
    @x = 256 - 64
    @y = 180

    @roof = Gosu::Image.from_blob(640, 2, rgba = "0\0\0\0" * (640*2))

    @score = 0
    @font = Gosu::Font.new(24)
    @start_game = true
  end


  def jump
  end

  def button_down(id)
    if id == Gosu::KB_SPACE
      @score += 1
      @start_game = false 
      jump
    end

    if id == Gosu::KB_ESCAPE
      close
    end
  end

  def update
    @x = @x.clamp(0, 480)
    @y = @y.clamp(128, 256)
  end

  def draw
    frame_index = (Gosu.milliseconds / 100) % @bulbasaur.size
    static_image = (Gosu.milliseconds / 250) % @standing_bulbasaur.size
    standing_bulbasaur = @bulbasaurs[static_image]
    animation = @bulbasaur[frame_index]
    @font.draw_text("#{@score}", 10,10,10)
    @roof.draw(0, 320 - animation.height)


    if @start_game
      @font.draw_text("PRESS SPACE TO START JUMPING", 144, 50, 10)
      standing_bulbasaur.draw(@x, @y)
    else
      @font.draw_text("", 50,50,10)
      animation.draw(@x, @y)
    end

  end
end

Game.new.show