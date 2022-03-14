module Rchess
  class CastlingTracker
    def initialize
      @white_king_castling_pattern = WhiteKingSideCastlingPattern.new
      @white_queen_castling_pattern = WhiteQueenSideCastlingPattern.new
      @black_king_castling_pattern = BlackKingSideCastlingPattern.new
      @black_queen_castling_pattern = BlackQueenSideCastlingPattern.new

      @white_king_castling_possible = true
      @white_queen_castling_possible = true
      @black_king_castling_possible = true
      @white_king_castling_possible = true
    end

    def perform_do_move(movable)

    end

    def perform_undo_move(movable)

    end
  end
end