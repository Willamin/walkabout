module Walkabout
  abstract class Entity
    property :x, :y, :speed, :delete_me
    @x : Int32
    @y : Int32
    @speed : Int32 = 0
    @delete_me = false

    def initialize(@x : Int32, @y : Int32)
    end

    def update(dt)
    end

    def draw
    end
  end
end

alias Entity = Walkabout::Entity
