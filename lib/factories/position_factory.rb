class PositionFactory
  class << self
    def create_by_coordinates(x, y)
      return nil unless Position.coordinates_in_range? x, y
      Position.new(x, y)
    end

    def create_by_notation(notation)
      unless notation.is_a? String
        raise ArgumentError.new('Notation must be a string')
      end

      unless notation.length == 2
        raise ArgumentError.new('Notation string length must be equal 2')
      end

      x = PositionNotation::LETTERS.index notation[0]
      y = notation[1].to_i - 1

      self.create_by_coordinates(x, y)
    end

    def create_by_offset(position, offset_x:, offset_y:)
      unless position.is_a? Position
        raise ArgumentError.new('Position argument must be a Position class instance')
      end

      unless offset_x.is_a?(Integer) && offset_y.is_a?(Integer)
        raise ArgumentError.new('offset_x and offset_y arguments must be an integers')
      end

      create_by_coordinates position.x + offset_x, position.y + offset_y
    end

    def create_by_direction(position, direction)
      unless position.is_a? Position
        raise ArgumentError.new 'Position argument must be a Position class instance'
      end

      unless direction.is_a? MoveDirection
        raise ArgumentError.new 'Direction argument must be a MoveDirection class instance'
      end

      x = position.x
      y = position.y

      if direction.left?
        x -= 1
      elsif direction.right?
        x += 1
      elsif direction.up?
        y += 1
      elsif direction.down?
        y -= 1
      elsif direction.top_left?
        x -= 1
        y += 1
      elsif direction.top_right?
        x += 1
        y += 1
      elsif direction.down_left?
        x -= 1
        y -= 1
      elsif direction.down_right?
        x += 1
        y -= 1
      end

      return nil unless Position.coordinates_in_range? x, y

      create_by_coordinates x, y
    end
  end
end