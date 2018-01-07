module Walkabout
  class Bouncer < Entity
    property :moving_right
    @moving_right : Bool = true
    @speed = 500

    def draw(m : Molly)
      m.set_color(SDL::Color.new(240, 100, 100))
      m.draw_rect(@x, @y, 100, 100)
    end

    def inspect(io)
      io << "Bouncer{(#{x}, #{y}), "
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
