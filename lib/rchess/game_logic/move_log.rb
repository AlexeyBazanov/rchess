module Rchess
  class MoveLog
    attr_reader :moves

    def initialize
      @moves = []
    end

    def add_move(move)
      @moves.append move
    end

    def pop_move
      @moves.pop
    end

    def history
      @moves.map.with_index { |move, index| "#{index+1}. #{move.notation}" }
    end

    def taken_figures(color)
      taken_figures = []
      @moves.each do |move|
        if move.has_attacked_figure? and move.attacked_figure.color.same? color
          taken_figures << move.attacked_figure
        end
      end
      taken_figures
    end
  end
end