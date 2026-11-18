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

    @bulbasaur_cry = Gosu::Sample.new(File.join(__dir__, "media/sfx/bulbasaur-cry.mp3"))
    @jumping_sfx = Gosu::Sample.new(File.join(__dir__, "media/sfx/jumping.mp3"))
    @landing_sfx = Gosu::Sample.new(File.join(__dir__, "media/sfx/landing.mp3"))
    @bgm = Gosu::Song.new(File.join(__dir__, "media/music/2008-Toyota-Corolla.flac"))
    @bgm.volume = 0.25

    @velocity = 0
    @gravity =  0.5
    @is_jumping = false

    @score = 0
    @font = Gosu::Font.new(24)
    @start_game = false
    @draw_character = true
  end


  def button_down(id)
    case id
  
    when Gosu::KB_SPACE
      @bgm.play if @draw_character
      @bulbasaur_cry.play(0.25) if @score == 0
      @jumping_sfx.play(0.25) if @draw_character && !@is_jumping
      @score += 1 if @draw_character && !@is_jumping
      @start_game = true 
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
    # @x = @x.clamp(0, 480)
    # @y = @y.clamp(0, 640)

    if @y > 180
      @y = 180
      @velocity = 0
      @is_jumping = false
      @landing_sfx.play(0.25)
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
    # @roof.draw(0, 320 - animation.height)


    if !@start_game
      @font.draw_text_rel("PRESS SPACE TO START JUMPING", width / 2, height / 5, 1, rel_x = 0.5, rel_y = 0.5)
      standing_bulbasaur.draw(@x, @y)
    else
      @font.draw_text("", 50,50,10)
      animation.draw(@x, @y) if @draw_character
      indicator.draw(256 - 64, 8, 10) if @draw_character
    end

    if @start_game && frame_index >= 4 && frame_index <= 7 && !@is_jumping
      @draw_character = false
      @bgm.stop
    end

    if !@draw_character
      @font.draw_text_rel("GAME OVER", width / 2, height / 5, 1, rel_x = 0.5, rel_y = 0.5)
      @font.draw_text_rel("PRESS E TO RESTART", width / 2, height / 4, 1, rel_x = 0.5, rel_y = 0.5)

      if Gosu.button_down? Gosu::KB_E 
        restart
      end
    end

    def restart
      @velocity = 0
      @gravity =  0.5
      @is_jumping = false
      @score = 0
      @start_game = false
      @draw_character = true
      @x = 256 - 64
      @y = 180
    end


  end
end

Game.new.show