module Walkabout
  class Player < Entity
    @speed = 200
    @facing_left = false

    def update(dt, m : Molly)
      if m.keyboard_pressed?(Key::RIGHT)
        @x += (@speed * dt).to_i
        @facing_left = false
      end

      if m.keyboard_pressed?(Key::UP)
        @y -= (@speed * dt).to_i
      end

      if m.keyboard_pressed?(Key::LEFT)
        @x -= (@speed * dt).to_i
        @facing_left = true
      end

      if m.keyboard_pressed?(Key::DOWN)
        @y += (@speed * dt).to_i
      end
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
