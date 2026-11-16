require "gosu"

class Game < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "Bulbasaur Jump"
    @bulbasaurs = Gosu::Image.load_tiles("media/img/bulbasaur-tilesheet.png", 256, 256, tileable: true)
    @bulbasaur = @bulbasaurs[0..10]
    @standing_bulbasaur = @bulbasaurs[0..2]
    @x = 256 - 64
    @y = 180

    @roof = Gosu::Image.from_blob(640, 2, rgba = "0\0\0\0" * (640*2))

    @score = 0
    @font = Gosu::Font.new(24)

    @jumps = 0
  end


  #TODO: Scoring mechnic

  def button_down(id)
    case id
    when Gosu::KB_SPACE
      @jumps += 1
    end
  end

  def update
    @x = @x.clamp(0, 480)
    @y = @y.clamp(128, 256)

    if Gosu.button_down?(Gosu::KB_ESCAPE)
      close
    end
  end

  def draw
    frame_index = (Gosu.milliseconds / 100) % @bulbasaur.size
    static_image = (Gosu.milliseconds / 250) % @standing_bulbasaur.size
    standing_bulbasaur = @bulbasaurs[static_image]
    animation = @bulbasaur[frame_index]

    while @jumps < 1
      standing_bulbasaur.draw(@x, @y)
    else
      animation.draw(@x, @y)
    end

    @font.draw_text("#{@score}", 10,10,10)
    @roof.draw(0, 320 - animation.height)
  end
end

Game.new.show