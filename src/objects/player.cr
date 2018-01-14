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

    def update(dt, m : Molly)
      move(dt, m)
      shoot(dt, m)
      @shoot_timer -= dt
      if @shoot_timer < 0
        @shoot_timer = 0
      end
    end

    def draw(m : Molly)
      m.draw_sprite(@x, @y, m.load_sprite(SPRITE_PATH), 3, 3, flip_x: @facing_left)
    end

    def shoot!
      @shoot_timer = 0.5
    end

    def shoot(dt, m)
      if @shoot_timer > 0
        return
      end

      if m.keyboard_pressed?(Key::D)
        shoot!
        m.do_both(Stone.new(@x, @y, :right))
        return
      end

      if m.keyboard_pressed?(Key::W)
        shoot!
        m.do_both(Stone.new(@x, @y, :up))
        return
      end

      if m.keyboard_pressed?(Key::A)
        shoot!
        m.do_both(Stone.new(@x, @y, :left))
        return
      end

      if m.keyboard_pressed?(Key::S)
        shoot!
        m.do_both(Stone.new(@x, @y, :down))
        return
      end
    end

    def move(dt, m)
      movement = MovementVector.new
      if m.keyboard_pressed?(Key::RIGHT)
        movement.x += (@speed * dt).to_i
        @facing_left = false
      end

      if m.keyboard_pressed?(Key::UP)
        movement.y -= (@speed * dt).to_i
      end

      if m.keyboard_pressed?(Key::LEFT)
        movement.x -= (@speed * dt).to_i
        @facing_left = true
      end

      if m.keyboard_pressed?(Key::DOWN)
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
