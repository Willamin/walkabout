require "yaml"
require "molly2d"

require "./entity"
require "./objects/*"

module Walkabout
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end

class Molly
  def load
    puts "walkabout load v#{Walkabout::VERSION}"
    @player = Player.new(300, 300)
    @background = SDL::Color.new(62, 41, 52)
  end

  def update(dt)
    @player.try &.update(dt, self)
  end

  def draw
    @player.try &.draw(self)
  end
end

Molly2d.run
