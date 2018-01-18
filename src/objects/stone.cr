module Walkabout
  class Stone < Entity
    SPRITE_PATH = "#{__DIR__}/../../res/stone.gif"

    @speed = 300

    def initialize(@x, @y, @direction : Symbol)
    end

    def draw
      Molly.draw_sprite(@x, @y, Molly.load_sprite(SPRITE_PATH), 3, 3)
    end

    def update(dt)
      case @direction
      when :right
        @x += (speed * dt).to_i
      when :up
        @y -= (speed * dt).to_i
      when :left
        @x -= (speed * dt).to_i
      when :down
        @y += (speed * dt).to_i
      end

      if @x < -4.tiles || @x > 19.tiles || @y < -4.tiles || @y > 19.tiles
        @delete_me = true
      end
    end
  end
end

alias Stone = Walkabout::Stone
