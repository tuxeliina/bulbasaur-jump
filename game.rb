require "gosu"

class Game < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "Bulbasaur Jump"
    @bulbasaurs = Gosu::Image.load_tiles("media/img/bulbasaur-tilesheet.png", 256, 256)
    @count = 0
    @bulbasaur = @bulbasaurs[@count]
    @x = 256 - 64
    @y = 180

    @roof = Gosu::Image.from_blob(640, 2, rgba = "0\0\0\0" * (640*2))

    @score = 0
    @font = Gosu::Font.new(24)
  end

  def draw
    @bulbasaur.draw(@x, @y)
    @font.draw_text("#{@score}", 10,10,10)
    @roof.draw(0, 320 - @bulbasaur.height)
  end

  def score
    if bulbasaur 
      @score += 1
    end
  end

  # def collision()
  #   Gosu.distance(@x, @y, @x, 320 - @
  # end

  def jump
    def jump_up
      @y -= 5
    end
    def fall_down
      @y += 5
    end

    if Gosu.button_down?(Gosu::KB_SPACE)
      jump_up
    else
      fall_down
    end
  end

  def update
    if Gosu.button_down?(Gosu::KB_SPACE)
      @y -= 5
    else
      @y += 5
    end

    @count += 1



    # jump
    # if collision == true
    #   score
    # end

    @x = @x.clamp(0, width - @bulbasaur.width)
    @y = @y.clamp(128, height - @bulbasaur.height)

    if Gosu.button_down?(Gosu::KB_ESCAPE)
      close
    end
  end
end

Game.new.show