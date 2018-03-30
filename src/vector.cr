struct Vector
  property x : Float64, y : Float64

  def initialize(@x = 0_f64, @y = 0_f64)
  end

  def initialize(x : Int32, y : Int32)
    @x = x.to_f
    @y = y.to_f
  end

  def angle
    0_f64
  end

  def magnitude
    Math.sqrt(x**2 + y**2)
  end

  def +(other : Vector)
    v = Vector.new
    v.x = self.x + other.x
    v.y = self.y + other.y
    v
  end
end
