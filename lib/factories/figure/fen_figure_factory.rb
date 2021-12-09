class FenFigureFactory < AbstractFigureFactory
  def create_figure(name)
    color = color_by_name name
    case name
      when *FenNotation::KING_SIGNS then King.new name, color
      when *FenNotation::QUEEN_SIGNS then Queen.new name, color
      when *FenNotation::BISHOP_SIGNS then Bishop.new name, color
      when *FenNotation::KNIGHT_SIGNS then Knight.new name, color
      when *FenNotation::ROOK_SIGNS then Rook.new name, color
      when *FenNotation::PAWN_SIGNS then Pawn.new name, color
      else raise "'#{name}' is incorrect fen figure sign!"
    end
  end

  private

  def color_by_name(name)
    if name.upcase == name then ColorFactory::create_white else ColorFactory::create_black end
  end
end