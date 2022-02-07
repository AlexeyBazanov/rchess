module Rchess
  class MoveDirection
    STRAIGHT = { up: 'up', down: 'down', left: 'left', right: 'right' }
    DIAGONAL = { top_left: 'top_left', top_right: 'top_right', down_left: 'down_left', down_right: 'down_right'}

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def straight?
      STRAIGHT.include? @name.to_sym
    end

    def diagonal?
      DIAGONAL.include? @name.to_sym
    end

    def vertical?
      up? or down?
    end

    def horizontal?
      left? or right?
    end

    def up?
      name == STRAIGHT[:up]
    end

    def down?
      name == STRAIGHT[:down]
    end

    def left?
      name == STRAIGHT[:left]
    end

    def right?
      name == STRAIGHT[:right]
    end

    def top_left?
      name == DIAGONAL[:top_left]
    end

    def top_right?
      name == DIAGONAL[:top_right]
    end

    def down_left?
      name == DIAGONAL[:down_left]
    end

    def down_right?
      name == DIAGONAL[:down_right]
    end
  end
end