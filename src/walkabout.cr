require "yaml"
require "molly2d"
require "sdl"
require "./*"

class Molly
  def load
    puts "walkabout load v#{Walkabout::VERSION}"
    @player = Player.new(50, 50)
  end

  def update(dt)
    @player.try do |p|
      if p.moving_right
        p.x += (p.speed * dt).to_i
      else
        p.x -= (p.speed * dt).to_i
      end

      if p.x > 800 - 100
        p.moving_right = false
      end

      if p.x < 0
        p.moving_right = true
      end
    end
  end

  def draw
    @player.try &.draw(self)
  end
end

Molly2d.run
