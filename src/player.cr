module Walkabout
  class Player
    property :x, :y, :speed
    @x : Int32
    @y : Int32
    @speed : Int32 = 300

    def initialize(@x : Int32, @y : Int32)
    end

    def draw(m : Molly)
      m.set_color(SDL::Color.new(100, 240, 100))
      m.draw_rect(@x, @y, 50, 50)
    end

    def inspect(io)
      io << "Player{(#{x}, #{y}) "
      io << " @ #{@speed}}\n"
    end
  end
end

alias Player = Walkabout::Player
