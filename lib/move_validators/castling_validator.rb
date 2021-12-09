class CastlingValidator < MoveValidator

  def validate(castling)
    unless figures_present? castling
      castling.prohibition = MoveProhibitionFactory::create_figure_not_present
      return false
    end

    unless figures_not_move? castling
      castling.prohibition = MoveProhibitionFactory::create_figure_already_move
      return false
    end

    unless places_for_moves_free? castling
      castling.prohibition = MoveProhibitionFactory::create_cell_not_free
      return false
    end
    
    true
  end

  private

  def figures_present?(castling)
    figure_present? castling.king_position and figure_present? castling.rook_position
  end

  def figures_not_move?(castling)
    get_figure(castling.king_position).moves_count == 0 and
    get_figure(castling.rook_position).moves_count == 0
  end

  def places_for_moves_free?(castling)
    not figures_present? castling.king_move_position and
    not figure_present? castling.rook_move_position and
    not (castling.has_through? and figure_present? castling.through_position)
  end

  def figure_present?(position)
    @field.figure_present? position
  end

  def get_figure(position)
    @field.figure_by_position position
  end
end