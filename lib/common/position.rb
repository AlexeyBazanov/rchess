class Position
  START = 0
  FINISH = 7
  LIST = (START..FINISH).to_a

  attr_reader :x, :y, :notation

  def initialize(x, y)
    @x = x
    @y = y
    @notation = PositionNotation.new self
  end

  def same?(position)
    same_x? position and same_y? position
  end

  def same_x?(position)
    position.x == x
  end

  def same_y?(position)
    position.y == y
  end

  def nearby_x?(position)
    position.x == x + 1 or position.x == x - 1
  end

  def nearby_y?(position)
    position.y == y + 1 or position.y == y - 1
  end

  def self.acceptable?(value)
    value.is_a? Integer and value.between? START, FINISH
  end
end