class MoveDirectionFactory
  class << self
    def create_all
      create_diagonal + create_vertical_and_horizontal
    end

    def create_vertical_and_horizontal
      create_vertical + create_horizontal
    end

    def create_horizontal
      [create_left, create_right]
    end

    def create_vertical
      [create_up, create_down]
    end

    def create_diagonal
      [create_top_left, create_top_right, create_down_left, create_down_right]
    end

    def create_up
      MoveDirection.new MoveDirection::STRAIGHT[:up]
    end

    def create_down
      MoveDirection.new MoveDirection::STRAIGHT[:down]
    end

    def create_left
      MoveDirection.new MoveDirection::STRAIGHT[:left]
    end

    def create_right
      MoveDirection.new MoveDirection::STRAIGHT[:right]
    end

    def create_top_left
      MoveDirection.new MoveDirection::DIAGONAL[:top_left]
    end

    def create_top_right
      MoveDirection.new MoveDirection::DIAGONAL[:top_right]
    end

    def create_down_left
      MoveDirection.new MoveDirection::DIAGONAL[:down_left]
    end

    def create_down_right
      MoveDirection.new MoveDirection::DIAGONAL[:down_right]
    end
  end
end