module Walkabout
  class MovementVector
    property x, y

    def initialize(@x : Float64 = 0_f64, @y : Float64 = 0_f64)
    end
  end

  class Player < Entity
    @speed = 200
    @facing_left = false

    def update(dt, m : Molly)
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

    def draw(m : Molly)
      m.set_color(Color.new(100, 100, 240))

      m.oldman.try do |sprite|
        m.draw_sprite(@x, @y, sprite, 4, 4, flip_x: @facing_left)
      end
    end

    def inspect(io)
      io << "Player{(#{@x}, #{@y}) "
      io << " @ #{@speed}}\n"
    end
  end
end

alias Player = Walkabout::Player
