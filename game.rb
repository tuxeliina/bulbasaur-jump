require "gosu"

class Game < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "Bulbasaur Jump"
    @bulbasaurs = Gosu::Image.load_tiles("media/img/bulbasaur-jumping-2.png", 256, 256, tileable: true)
    @jump_indicator = Gosu::Image.load_tiles("media/img/jump-indicator.png", 256, 256, tileable: true)
    @bulbasaur = @bulbasaurs[0..10]
    @standing_bulbasaur = @bulbasaurs[0..2]
    @x = 256 - 64
    @y = 180

    @velocity = 0
    @gravity =  0.5
    @is_jumping = false

    @score = 0
    @font = Gosu::Font.new(24)
    @start_game = true
  end
        
  def button_down(id)
    case id
  
    when Gosu::KB_SPACE
      @score += 1
      @start_game = false 
      jump unless @is_jumping
    end

    if id == Gosu::KB_ESCAPE
      close
    end
  end

  def jump
    @velocity = -10
    @is_jumping = true
  end

  def update
    if @y > 180
      @y = 180
      @velocity = 0
      @is_jumping = false
    end
    
    if @is_jumping
      @y += @velocity
      @velocity += @gravity
    end
  end

  def draw
    frame_index = (Gosu.milliseconds / 100) % @bulbasaur.size
    static_image = (Gosu.milliseconds / 250) % @standing_bulbasaur.size
    standing_bulbasaur = @bulbasaurs[static_image]
    animation = @bulbasaur[frame_index]
    indicator = @jump_indicator[frame_index]
    @font.draw_text("#{@score}", 10,10,10)

    def game_over
      animation = false
      indicator = false
      @font.draw_text("GAME OVER", 50, 50, 10)
    end


    if @start_game
      @font.draw_text("PRESS SPACE TO START JUMPING", 144, 50, 10)
      standing_bulbasaur.draw(@x, @y)
    else
      @font.draw_text("", 50,50,10)
      animation.draw(@x, @y)
      indicator.draw(20, 10, 10)
    end

    if @jump_indicator[3..6] && @is_jumping == false
      game_over
    end

  end
end

Game.new.show