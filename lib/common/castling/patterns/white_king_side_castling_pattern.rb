class WhiteKingSideCastlingPattern < CastlingPattern
  def initialize
    @king_position = PositionFactory::create_by_notation 'e1'
    @rook_position = PositionFactory::create_by_notation 'h1'
    @king_move_position = PositionFactory::create_by_notation 'g1'
    @rook_move_position = PositionFactory::create_by_notation 'f1'
    @side = CastlingSideFactory::create_king_side
  end
end