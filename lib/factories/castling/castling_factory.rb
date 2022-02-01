class CastlingFactory
  attr_reader :field

  def initialize(field)
    @field = field
  end

  def create_castlings(king_color)
    king_side_castling = create_king_side_castling king_color
    queen_side_castling = create_queen_side_castling king_color
    castlings = []
    castlings.push king_side_castling if king_side_castling
    castlings.push queen_side_castling if queen_side_castling
    castlings
  end

  def create_king_side_castling(king_color)
    if king_color.white?
      pattern = WhiteKingSideCastlingPattern.new
    else
      pattern = BlackKingSideCastlingPattern.new
    end
    create_castling pattern
  end

  def create_queen_side_castling(king_color)
    if king_color.white?
      pattern = WhiteQueenSideCastlingPattern.new
    else
      pattern = BlackQueenSideCastlingPattern.new
    end
    create_castling pattern
  end

  private

  def create_castling(castling_pattern)
    king = @field.figure_by_position castling_pattern.king_position
    rook = @field.figure_by_position castling_pattern.rook_position
    return if king.nil? || rook.nil?

    king_move = Move.new king, castling_pattern.king_position, castling_pattern.king_move_position
    rook_move = Move.new rook, castling_pattern.rook_position, castling_pattern.rook_move_position
    Castling.new king_move, rook_move, castling_pattern.side, castling_pattern.through_position
  end
end