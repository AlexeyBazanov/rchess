class CastlingPattern
  attr_reader :king_position, :rook_position,
              :king_move_position, :rook_move_position,
              :through_position, :side

  def has_through?
    @through_position.is_a? Position
  end
end