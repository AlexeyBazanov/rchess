module Rchess
  class BlackQueenSideCastlingPattern < CastlingPattern
    def initialize
      @king_position = PositionFactory::create_by_notation 'e8'
      @rook_position = PositionFactory::create_by_notation 'a8'
      @king_move_position = PositionFactory::create_by_notation 'c8'
      @rook_move_position = PositionFactory::create_by_notation 'd8'
      @through_position = PositionFactory::create_by_notation 'b8'
      @side = CastlingSideFactory::create_queen_side
    end
  end
end