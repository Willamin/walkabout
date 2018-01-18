module Walkabout
  class Wall < Entity
    SPRITE_PATH = "#{__DIR__}/../../res/wall.gif"

    def draw
      Molly.draw_sprite(@x, @y, Molly.load_sprite(SPRITE_PATH), 3, 3)
    end
  end

  class WallBottom < Wall
    def draw
      Molly.draw_sprite(@x, @y, Molly.load_sprite(SPRITE_PATH), 3, 3, angle: 180)
    end
  end

  class WallLeft < Wall
    def draw
      Molly.draw_sprite(@x, @y, Molly.load_sprite(SPRITE_PATH), 3, 3, angle: 270)
    end
  end

  class WallRight < Wall
    def draw
      Molly.draw_sprite(@x, @y, Molly.load_sprite(SPRITE_PATH), 3, 3, angle: 90)
    end
  end
end

alias Wall = Walkabout::Wall
alias WallBottom = Walkabout::WallBottom
alias WallLeft = Walkabout::WallLeft
alias WallRight = Walkabout::WallRight
