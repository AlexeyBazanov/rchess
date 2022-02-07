module Rchess
  class Position
    START = 0
    FINISH = 7
    RANGE = (START..FINISH).to_a

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

    def self.coordinates_in_range?(x, y)
      RANGE.include?(x) && RANGE.include?(y)
    end
  end
end

