module Rchess
  class MoveLog
    attr_reader :moves

    def initialize
      @moves = []
      @last_move = -1
    end

    def has_moves?
      @last_move > -1
    end

    def add_move(move)
      if @last_move < @moves.length - 1
        moves = has_moves? ? @moves[0..@last_move] : []
        @moves = moves
      end
      @moves.append move
      @last_move += 1
    end

    def prev_move
      return unless has_moves?
      move = @moves[@last_move]
      @last_move -= 1
      move
    end

    def next_move
      return if @last_move >= @moves.length - 1
      @last_move += 1
      @moves[@last_move]
    end

    def moves_history
      @moves.map.with_index { |move, index| "#{index+1}. #{move.notation}" }
    end

    def white_taken_figures_history
      taken_figures ColorFactory.create_white
    end

    def black_taken_figures_history
      taken_figures ColorFactory.create_black
    end

    def taken_figures_history(color=nil)
      taken_figures(color).map { |figure| "#{figure.notation}"}
    end

    def taken_figures(color=nil)
      taken_figures = []
      @moves.each do |move|
        is_color_suit = color.nil? ? true : move.attacked_figure.color.same?(color)
        if move.has_attacked_figure? and is_color_suit
          taken_figures << move.attacked_figure
        end
      end
      taken_figures
    end
  end
end