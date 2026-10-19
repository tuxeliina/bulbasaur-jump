require "gosu"

class Game < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "Bulbasaur Jump"
    @bulbasaur = Gosu::Image.new("media/img/bulbasaur1.png")
    @x = 270
    @y = 180

    @score = 0
    @font = Gosu::Font.new(24)
  end

  def draw
    @bulbasaur.draw(@x, @y)
    @font.draw_text("#{@score}", 10,10,10)
  end

  def score
    if bulbasaur 
      @score += 1
    end
  end

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
    # if Gosu.button_down?(Gosu::KB_SPACE)
    # #   @y -= 5
    # # else
    # #   @y += 5
    # end

    # @x = @x.clamp(0, width - @bulbasaur.width)
    @y = @y.clamp(320, height - @bulbasaur.height)

    if Gosu.button_down?(Gosu::KB_ESCAPE)
      close
    end
  end
end

Game.new.show