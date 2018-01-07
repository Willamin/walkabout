require "yaml"
require "molly2d"

require "./entity"
require "./objects/*"

module Walkabout
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end

class Molly
  @texture : SDL::Texture?

  def load
    puts "walkabout load v#{Walkabout::VERSION}"
    @bouncer = Bouncer.new(50, 50)
    @player = Player.new(300, 300)
    @texture = SDL::IMG.load("#{__DIR__}/../res/bg.png", @renderer)
  end

  def update(dt)
    @bouncer.try &.update(dt)
    @player.try &.update(dt, self)
  end

  def draw
    @texture.try do |t|
      @renderer.copy(t, dstrect: SDL::Rect[0, 0, 800, 600])
    end
    @bouncer.try &.draw(self)
    @player.try &.draw(self)
  end
end

Molly2d.run
