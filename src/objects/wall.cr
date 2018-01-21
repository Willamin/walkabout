module Walkabout
  class Wall < Entity
    SPRITE_PATH = "#{__DIR__}/../../res/wall.gif"

    def draw
      Molly.draw_sprite(@x, @y, Molly.load_sprite(SPRITE_PATH), 3, 3)
    end

    def self.build(x, y, invis)
      if invis
        Molly.do_both WallInvisible.new(x.tiles, y.tiles)
      else
        Molly.do_both Wall.new(x.tiles, y.tiles)
      end
    end
  end

  class WallInvisible < Wall
    def draw
    end
  end
end

alias Wall = Walkabout::Wall
alias WallInvisible = Walkabout::WallInvisible
