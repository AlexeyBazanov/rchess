class PositionFactory
  class << self
    def create_by_coordinates(x, y)
      Position.new(x, y) if Position.acceptable? x and Position.acceptable? y
    end

    def create_by_notation(notation)
      return nil unless notation.length.between? 1, 2
      x, y = Notation::parse_move notation
      self.create_by_coordinates(x, y)
    end

    def create_by_offset(position, offset_x:, offset_y:)
      create_by_coordinates position.x + offset_x, position.y + offset_y
    end

    def create_by_direction(position, direction)
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

      create_by_coordinates x, y
    end
  end
end