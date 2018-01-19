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
  VERSION   = {{ `shards version #{__DIR__}`.chomp.stringify }}
  TILE_SIZE = 48
end

alias W = Walkabout

module Molly
  data drawable_objects : Array(Entity) { [] of Entity }
  data updateable_objects : Array(Entity) { [] of Entity }

  def do_draw(e)
    Molly.drawable_objects << e
  end

  def do_update(e)
    Molly.updateable_objects << e
  end

  def do_both(e)
    Molly.updateable_objects << e
    Molly.drawable_objects << e
  end

  def load
    puts "walkabout load v#{Walkabout::VERSION}"
    Molly.window.size = {15.tiles, 15.tiles}
    Molly.do_both(Player.new(7.tiles, 7.tiles))
    (0..14).each { |i| Molly.do_draw(Wall.new(i.tiles, 0.tiles)) }
    (0..14).each { |i| Molly.do_draw(WallBottom.new(i.tiles, 14.tiles)) }
    (1..13).each { |i| Molly.do_draw(WallLeft.new(0, i.tiles)) }
    (1..13).each { |i| Molly.do_draw(WallRight.new(14.tiles, i.tiles)) }
    Molly.background = SDL::Color.new(62, 41, 52)
  end

  def update(dt)
    Molly.updateable_objects.reject! do |entity|
      entity.update(dt)
      entity.delete_me
    end
  end

  def draw
    Molly.drawable_objects.sort_by! { |entity| entity.y }
    Molly.drawable_objects.each &.draw
    # set_color(SDL::Color.new(255, 255, 255))
    # draw_text(3.tiles, 3.tiles, "entities: #{Walkabout::UPDATEABLE_OBJECTS.size}")
  end
end
