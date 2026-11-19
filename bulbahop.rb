=begin
Name: Bulbasaur Jump
Author: soosh
Date: 2026-11-19
Description: Bulbasaur wants to jump rope, can you help it jump as much as possible?
=end

require "gosu"

class Game < Gosu::Window
  # init all the heavy stuff
  def initialize
    super(640, 480)
    self.caption = "Bulbasaur Jump"
    @bulbasaurs = Gosu::Image.load_tiles(File.join(__dir__, "media/img/bulbasaur-jumping-2.png"), 256, 256, tileable: true)
    @jump_indicator = Gosu::Image.load_tiles(File.join(__dir__,"media/img/jump-indicator.png"), 256, 256, tileable: true)
    @background = Gosu::Image.new(File.join(__dir__, "media/img/alex-bg.png"), false)
    @bulbasaur = @bulbasaurs[0..10]
    @standing_bulbasaur = @bulbasaurs[0..2]
    @x = 256 - 64
    @y = 200

    @bulbasaur_cry = Gosu::Sample.new(File.join(__dir__, "media/sfx/bulbasaur-cry.mp3"))
    @jumping_sfx = Gosu::Sample.new(File.join(__dir__, "media/sfx/jumping.mp3"))
    @landing_sfx = Gosu::Sample.new(File.join(__dir__, "media/sfx/landing.mp3"))
    @bgm = Gosu::Song.new(File.join(__dir__, "media/music/2008-Toyota-Corolla.mp3"))
    @bgm.volume = 0.25

    @velocity = 0
    @gravity =  0.5
    @is_jumping = false

    @score = 0
    @font = Gosu::Font.new(24)
    @start_game = false
    @draw_character = true

    @speed = 100
    @frame_index = 4
    @frame_timer = 0
    @last_time = Gosu.milliseconds

  end

  # speeds up the gameplay for a more exiting gameplay loop
  def speed_up
    if @score > 0 && @score % 10 == 0
      @speed = [@speed - 10, 20].max
      @velocity -= 1
    end
  end

  # checks for single button presses
  def button_down(id)
    case id
  
    when Gosu::KB_SPACE, Gosu::KB_UP
      @bgm.play if @draw_character
      @bulbasaur_cry.play(0.25) if @score == 0
      @jumping_sfx.play(0.25) if @draw_character && !@is_jumping
      @score += 1 if @draw_character && !@is_jumping
      if !@start_game
        @start_game = true
      end
      jump unless @is_jumping
      speed_up
    end

    if id == Gosu::KB_ESCAPE
      close
    end
  end

  # jumping function
  def jump
    @velocity = -10
    @is_jumping = true
  end

  # restart function for when it's game over
  def restart
    @velocity = 0
    @gravity =  0.5
    @is_jumping = false
    @score = 0
    @start_game = false
    @draw_character = true
    @x = 256 - 64
    @y = 200

    @frame_index = 4
    @frame_timer = 0
    @last_time = Gosu.milliseconds
    @speed = 100
  end

  # gameplay loop (i think idrk gosu that well)
  def update
    if @y > 200
      @y = 200
      @velocity = 0
      @is_jumping = false
      @landing_sfx.play(0.25)
    end

    if @is_jumping
      @y += @velocity
      @velocity += @gravity
    end

    now = Gosu.milliseconds
    dt = now - @last_time
    @last_time = now

    if @start_game && @draw_character
      @frame_timer += dt
      if @frame_timer >= @speed
        @frame_index = (@frame_index + 1) % @bulbasaur.size
        @frame_timer = 0
      end
    end

  end

  # draws out that which needs to be shown on screen
  def draw
    @background.draw(0, 0, 0)
    static_image = (Gosu.milliseconds / 250) % @standing_bulbasaur.size
    standing_bulbasaur = @bulbasaurs[static_image]
    animation = @bulbasaur[@frame_index]
    indicator = @jump_indicator[@frame_index]
    @font.draw_text("Jumps: #{@score}", 10,10,10, 1.0, 1.0, Gosu::Color::BLACK)

    # checks if game has been started yet
    if !@start_game
      @font.draw_text_rel("PRESS SPACE TO START JUMPING", width / 2, height / 5, 1, rel_x = 0.5, rel_y = 0.5, 1.0, 1.0, Gosu::Color::BLACK)
      standing_bulbasaur.draw(@x, @y)
    else
      @font.draw_text("", 50,50,10)
      animation.draw(@x, @y) if @draw_character
      indicator.draw(256 - 64, 8, 10) if @draw_character
    end

    # lose condition
    if @start_game && @frame_index >= 4 && @frame_index <= 7 && !@is_jumping
      @draw_character = false
      @bgm.stop
    end

    # game over screen
    if !@draw_character
      @font.draw_text_rel("GAME OVER", width / 2, height / 5, 1, rel_x = 0.5, rel_y = 0.5, 1.0, 1.0, Gosu::Color::BLACK)
      @font.draw_text_rel("PRESS E TO RESTART", width / 2, height / 4, 1, rel_x = 0.5, rel_y = 0.5, 1.0, 1.0, Gosu::Color::BLACK)

      if Gosu.button_down? Gosu::KB_E 
        restart
      end

    end
  end
end

Game.new.show unless defined?(Ocran)