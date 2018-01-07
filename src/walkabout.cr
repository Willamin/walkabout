require "yaml"
require "molly2d"
require "sdl"

require "./entity"
require "./objects/*"

module Walkabout
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end

class Molly
  def load
    puts "walkabout load v#{Walkabout::VERSION}"
    @bouncer = Bouncer.new(50, 50)
    @player = Player.new(300, 300)
  end

  def update(dt)
    @bouncer.try do |b|
      if b.moving_right
        b.x += (b.speed * dt).to_i
      else
        b.x -= (b.speed * dt).to_i
      end

      if b.x > 800 - 100
        b.moving_right = false
      end

      if b.x < 0
        b.moving_right = true
      end
    end

    @player.try do |p|
      if keyboard_pressed?(Key::LEFT)
        p.x -= (p.speed * dt).to_i
      end

      if keyboard_pressed?(Key::RIGHT)
        p.x += (p.speed * dt).to_i
      end

      if keyboard_pressed?(Key::DOWN)
        p.y += (p.speed * dt).to_i
      end

      if keyboard_pressed?(Key::UP)
        p.y -= (p.speed * dt).to_i
      end
    end
  end

  def draw
    @bouncer.try &.draw(self)
    @player.try &.draw(self)
  end
end

Molly2d.run
