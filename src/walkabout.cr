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

module Molly
  # overridden Molly methods
  def load
    puts "walkabout load v#{Walkabout::VERSION}"
    window.size = {15.tiles, 15.tiles}
    initialize_objects
    Molly.background = Color.new(62, 41, 52)
  end

  def update(dt)
    updateable_objects.reject! do |entity|
      entity.update(dt)
      entity.delete_me
    end
  end

  def draw
    drawable_objects.sort_by! { |entity| entity.y }
    drawable_objects.each &.draw
    set_color(Color.new(255, 255, 255))
    draw_text(3.tiles, 3.tiles, "entities: #{updateable_objects.size}")
  end

  # add some custom utility data and methods

  data drawable_objects : Array(Entity) { [] of Entity }
  data updateable_objects : Array(Entity) { [] of Entity }

  def do_draw(e)
    drawable_objects << e
  end

  def do_update(e)
    updateable_objects << e
  end

  def do_both(e)
    updateable_objects << e
    drawable_objects << e
  end

  def initialize_objects
    do_both(Player.new(7.tiles, 7.tiles))
    (0..14).each { |i| do_draw(Wall.new(i.tiles, 0.tiles)) }
    (0..14).each { |i| do_draw(WallBottom.new(i.tiles, 14.tiles)) }
    (1..13).each { |i| do_draw(WallLeft.new(0, i.tiles)) }
    (1..13).each { |i| do_draw(WallRight.new(14.tiles, i.tiles)) }
  end
end
