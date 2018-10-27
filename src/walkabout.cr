require "yaml"
require "molly2d"

require "./constants"
require "./vector"
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

  def self.setup_console
    Molly.setup_console do
      listen_for "ping", ->(i : String) { puts "pong" }
      listen_for "exit", ->(i : String) { exit }
      listen_for "set", ->(i : String) do
        begin
          set_input = i[("set ".size)..-1]
          var_name = set_input.split("=")[0].try(&.strip) || "[invalid]"
          var_val = set_input.split("=")[1].try(&.strip) || "[invalid]"

          case var_name
          when "base_player_speed", "bps"
            var_val.to_i?.try { |x| Molly.base_player_speed = x }
          when "base_shot_speed", "bss"
            var_val.to_i?.try { |x| Molly.base_shot_speed = x }
          when "base_shot_delay", "bsd"
            var_val.to_f?.try { |x| Molly.base_shot_delay = x }
          else
            raise Molly2d::Console::Error.new
          end
        rescue e
          raise Molly2d::Console::Error.new(<<-MSG
            invalid set syntax.
            for setting a variable named x to 5, correct syntax is:
            set x = 5
          MSG
          )
        end
      end
    end
  end
end

module Molly
  # overridden Molly methods
  def load
    puts "walkabout v#{Walkabout::VERSION}"
    Walkabout.setup_console
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

    # along the top
    (0..14).each { |i| Wall.build(i, 0, (6..8).includes?(i)) }

    # along the bottom
    (0..14).each { |i| Wall.build(i, 14, (6..8).includes?(i)) }

    # along the left
    (1..13).each { |i| Wall.build(0, i, (6..8).includes?(i)) }

    # along the right
    (1..13).each { |i| Wall.build(14, i, (6..8).includes?(i)) }
  end
end
