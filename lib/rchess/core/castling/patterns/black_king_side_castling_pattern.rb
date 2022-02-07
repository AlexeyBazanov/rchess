module Rchess
  class BlackKingSideCastlingPattern < CastlingPattern
    def initialize
      @king_position = PositionFactory::create_by_notation 'e8'
      @rook_position = PositionFactory::create_by_notation 'h8'
      @king_move_position = PositionFactory::create_by_notation 'g8'
      @rook_move_position = PositionFactory::create_by_notation 'f8'
      @side = CastlingSideFactory::create_king_side
    end
  end
end