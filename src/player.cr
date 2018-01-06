module Walkabout
  VERSION = YAML.parse(File.read("shard.yml"))["version"]

  class Player
    property :x, :y, :speed, :moving_right
    @x : Int32
    @y : Int32
    @speed : Int32 = 500
    @moving_right : Bool = true

    def initialize(@x : Int32, @y : Int32)
    end

    def draw(m : Molly)
      m.set_color(SDL::Color.new(240, 100, 100))
      m.draw_rect(@x, @y, 100, 100)
    end

    def inspect(io)
      io << "Player{(#{x}, #{y}), "
      if @moving_right
        io << "->"
      else
        io << "<-"
      end
      io << " @ #{@speed}}\n"
    end
  end
end

alias Player = Walkabout::Player
