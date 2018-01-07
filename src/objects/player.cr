module Walkabout
  class Player < Entity
    @speed = 300

    def draw(m : Molly)
      m.set_color(SDL::Color.new(100, 100, 240))
      m.draw_rect(@x, @y, 50, 50)
    end

    def inspect(io)
      io << "Player{(#{x}, #{y}) "
      io << " @ #{@speed}}\n"
    end
  end
end

alias Player = Walkabout::Player
