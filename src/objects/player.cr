module Walkabout
  class MovementVector
    property x, y

    def initialize(@x : Float64 = 0_f64, @y : Float64 = 0_f64)
    end
  end

  class Player < Entity
    SPRITE_PATH = "#{__DIR__}/../../res/oldman.gif"
    @speed = 200
    @facing_left = false

    @shoot_timer = 0_f64

    def update(dt)
      move(dt)
      shoot(dt)
      @shoot_timer -= dt
      if @shoot_timer < 0
        @shoot_timer = 0
      end
    end

    def draw
      Molly.draw_sprite(@x, @y, Molly.load_sprite(SPRITE_PATH), 3, 3, flip_x: @facing_left)
    end

    def shoot!(dir)
      @shoot_timer = 0.5
      Molly.do_both(Stone.new(@x, @y, dir))
    end

    def shoot(dt)
      if @shoot_timer > 0
        return
      end

      if Molly.keyboard_pressed?(Key::D)
        shoot! :right
        return
      end

      if Molly.keyboard_pressed?(Key::W)
        shoot! :up
        return
      end

      if Molly.keyboard_pressed?(Key::A)
        shoot! :left
        return
      end

      if Molly.keyboard_pressed?(Key::S)
        shoot! :down
        return
      end
    end

    def move(dt)
      movement = MovementVector.new
      if Molly.keyboard_pressed?(Key::RIGHT)
        movement.x += (@speed * dt).to_i
        @facing_left = false
      end

      if Molly.keyboard_pressed?(Key::UP)
        movement.y -= (@speed * dt).to_i
      end

      if Molly.keyboard_pressed?(Key::LEFT)
        movement.x -= (@speed * dt).to_i
        @facing_left = true
      end

      if Molly.keyboard_pressed?(Key::DOWN)
        movement.y += (@speed * dt).to_i
      end

      if movement.x != 0 && movement.y != 0
        movement.x *= 0.707
        movement.y *= 0.707
      end

      @x += movement.x.to_i
      @y += movement.y.to_i
    end

    def inspect(io)
      io << "Player{(#{@x}, #{@y}) "
      io << " @ #{@speed}}\n"
    end
  end
end

alias Player = Walkabout::Player
