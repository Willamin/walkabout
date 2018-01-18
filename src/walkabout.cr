require "yaml"
require "molly2d"

require "./entity"
require "./objects/*"

struct Int32
  def pixels
    (self / Walkabout::TILE_SIZE).to_i
  end

  def tiles
    self * Walkabout::TILE_SIZE
  end
end

module Walkabout
  VERSION            = {{ `shards version #{__DIR__}`.chomp.stringify }}
  TILE_SIZE          = 48
  DRAWABLE_OBJECTS   = [] of Entity
  UPDATEABLE_OBJECTS = [] of Entity

  extend self

  def do_draw(e)
    Walkabout::DRAWABLE_OBJECTS << e
  end

  def do_update(e)
    Walkabout::UPDATEABLE_OBJECTS << e
  end

  def do_both(e)
    Walkabout::UPDATEABLE_OBJECTS << e
    Walkabout::DRAWABLE_OBJECTS << e
  end
end

alias W = Walkabout

module Molly
  def load
    puts "walkabout load v#{Walkabout::VERSION}"
    Molly.window.size = {15.tiles, 15.tiles}
    W.do_both(Player.new(7.tiles, 7.tiles))
    (0..14).each { |i| W.do_draw(Wall.new(i.tiles, 0.tiles)) }
    (0..14).each { |i| W.do_draw(WallBottom.new(i.tiles, 14.tiles)) }
    (1..13).each { |i| W.do_draw(WallLeft.new(0, i.tiles)) }
    (1..13).each { |i| W.do_draw(WallRight.new(14.tiles, i.tiles)) }
    Molly.background = SDL::Color.new(62, 41, 52)
  end

  def update(dt)
    Walkabout::UPDATEABLE_OBJECTS.reject! do |entity|
      entity.update(dt)
      entity.delete_me
    end
  end

  def draw
    Walkabout::DRAWABLE_OBJECTS.sort_by! { |entity| entity.y }
    Walkabout::DRAWABLE_OBJECTS.each &.draw
    # set_color(SDL::Color.new(255, 255, 255))
    # draw_text(3.tiles, 3.tiles, "entities: #{Walkabout::UPDATEABLE_OBJECTS.size}")
  end
end

Molly.run
