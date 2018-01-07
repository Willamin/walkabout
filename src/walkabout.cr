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
    @bouncer = Bouncer.new(50, 50)
    @player = Player.new(300, 300)
  end

  def update(dt)
    @bouncer.try &.update(dt)
    @player.try &.update(dt, self)
  end

  def draw
    @bouncer.try &.draw(self)
    @player.try &.draw(self)
  end
end

Molly2d.run
