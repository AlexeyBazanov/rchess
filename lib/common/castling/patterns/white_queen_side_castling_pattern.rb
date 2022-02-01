class WhiteQueenSideCastlingPattern < CastlingPattern
  def initialize
    @king_position = PositionFactory::create_by_notation 'e1'
    @rook_position = PositionFactory::create_by_notation 'a1'
    @king_move_position = PositionFactory::create_by_notation 'c1'
    @rook_move_position = PositionFactory::create_by_notation 'd1'
    @through_position = PositionFactory::create_by_notation 'b1'
    @side = CastlingSideFactory::create_queen_side
  end
end