require "../direction"

module Walkabout
  class Player < Entity
    SPRITE_PATH = "#{__DIR__}/../../res/oldman.gif"
    @speed_mod = 1
    @shot_speed_mod = 1
    @shot_delay_mod = 1

    @facing_left = false
    @shoot_timer = 0_f64
    @facing : Direction = Direction::Right

    enum Axis
      X
      Y
    end
    X = Axis::X
    Y = Axis::Y

    def update(dt)
      move(dt)

      handle_shooting(dt)
      @shoot_timer -= dt
      if @shoot_timer < 0
        @shoot_timer = 0
      end
    end

    def speed
      @speed_mod * Molly.base_player_speed
    end

    def shot_speed
      s = @shot_speed_mod * Molly.base_shot_speed
      if s < speed * 1.5
        s = speed * 1.5
      end
      s.to_i
    end

    def shot_delay
      @shot_delay_mod * Molly.base_shot_delay
    end

    def move(dt)
      movement_x = 0_f64
      movement_y = 0_f64

      if Molly.keyboard_pressed?(Key::RIGHT)
        movement_x += (speed * dt).to_i
        @facing = Direction::Right
      end

      if Molly.keyboard_pressed?(Key::UP)
        movement_y -= (speed * dt).to_i
      end

      if Molly.keyboard_pressed?(Key::LEFT)
        movement_x -= (speed * dt).to_i
        @facing = Direction::Left
      end

      if Molly.keyboard_pressed?(Key::DOWN)
        movement_y += (speed * dt).to_i
      end

      movement_x = ensure_clear(movement_x, X)
      movement_y = ensure_clear(movement_y, Y)

      if movement_x != 0 && movement_y != 0
        movement_x *= 0.707
        movement_y *= 0.707
      end

      @x += movement_x.to_i
      @y += movement_y.to_i
    end

    def outside_border?(axis : Axis, point)
      (point < 0 || point > (Molly.window.size[axis.to_i] - 1.tiles))
    end

    def ensure_clear(amount, axis : Axis)
      case axis
      when X
        point = amount + @x
      when Y
        point = amount + @y
      else
        return 0
      end

      if outside_border?(axis, point)
        0
      else
        amount
      end
    end

    def draw
      Molly.draw_sprite(
        @x,
        @y,
        Molly.load_sprite(SPRITE_PATH),
        3,
        3,
        flip_x: (@facing == Direction::Left)
      )
      Molly.set_color(Color.new(255, 255, 255))
    end

    def shoot(dir : Symbol)
      @shoot_timer = shot_delay
      Molly.do_both(Stone.new(@x, @y, dir, shot_speed))
    end

    def handle_shooting(dt : Float64)
      if @shoot_timer > 0
        return
      end

      case Molly
      when .keyboard_pressed?(Key::D)
        shoot :right
      when .keyboard_pressed?(Key::W)
        shoot :up
      when .keyboard_pressed?(Key::A)
        shoot :left
      when .keyboard_pressed?(Key::S)
        shoot :down
      end
    end

    def inspect(io)
      io << "Player{(#{@x}, #{@y}) "
      io << " @ #{@speed}}\n"
    end
  end
end

alias Player = Walkabout::Player
