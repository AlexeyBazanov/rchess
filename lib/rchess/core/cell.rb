module Rchess
  class Cell
    attr_accessor :position, :figure

    def initialize(position)
      @position = position
    end

    def has_figure?
      @figure.is_a? Figure
    end

    def clear_figure
      @figure = nil
    end
  end
end

