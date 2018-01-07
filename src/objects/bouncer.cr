module Walkabout
  class Bouncer < Entity
    property :moving_right
    @moving_right : Bool = true
    @speed = 500

    def update(dt)
      if moving_right
        @x += (@speed * dt).to_i
      else
        @x -= (@speed * dt).to_i
      end

      if @x > 800 - 100
        @moving_right = false
      end

      if @x < 0
        @moving_right = true
      end
    end

    def draw(m : Molly)
      m.set_color(SDL::Color.new(240, 100, 100))
      m.draw_rect(@x, @y, 100, 100)
    end

    def inspect(io)
      io << "Bouncer{(#{@x}, #{@y}), "
      if @moving_right
        io << "->"
      else
        io << "<-"
      end
      io << " @ #{@speed}}\n"
    end
  end
end

alias Bouncer = Walkabout::Bouncer
