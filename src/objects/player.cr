module Walkabout
  class Player < Entity
    @speed = 300

    def update(dt, m : Molly)
      if m.keyboard_pressed?(Key::RIGHT)
        @x += (@speed * dt).to_i
      end

      if m.keyboard_pressed?(Key::UP)
        @y -= (@speed * dt).to_i
      end

      if m.keyboard_pressed?(Key::LEFT)
        @x -= (@speed * dt).to_i
      end

      if m.keyboard_pressed?(Key::DOWN)
        @y += (@speed * dt).to_i
      end
    end

    def draw(m : Molly)
      m.set_color(Color.new(100, 100, 240))
      m.draw_rect(@x, @y, 50, 50)
    end

    def inspect(io)
      io << "Player{(#{@x}, #{@y}) "
      io << " @ #{@speed}}\n"
    end
  end
end

alias Player = Walkabout::Player
