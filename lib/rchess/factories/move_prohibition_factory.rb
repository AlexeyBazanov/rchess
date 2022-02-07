module Rchess
  class MoveProhibitionFactory
    class << self
      def create_figure_not_present
        MoveProhibition.new 'The figure is not present'
      end

      def create_figure_already_move
        MoveProhibition.new 'The figure is already moves'
      end

      def create_cell_not_free
        MoveProhibition.new 'The cell for the move is not free'
      end

      def create_check_king_move
        MoveProhibition.new 'This is a check move'
      end

      def create_king_under_attack
        MoveProhibition.new 'The king is under attack'
      end

      def create_covered_check
        MoveProhibition.new 'The move opens the check on the king'
      end

      def create_incorrect_pawn_move
        MoveProhibition.new 'This pawn move is incorrect'
      end

      def create_cell_is_under_attack
        MoveProhibition.new 'This cell is under attack'
      end
    end
  end
end