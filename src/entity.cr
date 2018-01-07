module Walkabout
  abstract class Entity
    property :x, :y, :speed
    @x : Int32
    @y : Int32
    @speed : Int32 = 0

    def initialize(@x : Int32, @y : Int32)
    end
  end
end
