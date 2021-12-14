# frozen_string_literal: true

class CastlingValidator < MoveValidator
  def validate(castling)
    unless figures_in_place? castling
      castling.prohibition = MoveProhibitionFactory.create_figure_not_present
      return false
    end

    unless figures_not_move? castling
      castling.prohibition = MoveProhibitionFactory.create_figure_already_move
      return false
    end

    unless moves_positions_free? castling
      castling.prohibition = MoveProhibitionFactory.create_cell_not_free
      return false
    end

    true
  end

  private

  def figures_in_place?(castling)
    figure_present? castling.king_position and figure_present? castling.rook_position
  end

  def figures_not_move?(castling)
    get_figure(castling.king_position).moves_count.zero? and
      get_figure(castling.rook_position).moves_count.zero?
  end

  def moves_positions_free?(castling)
    king_move_position_free? castling and
      rook_move_position_free? castling and
      through_move_position_free? castling
  end

  def king_move_position_free?(castling)
    !figure_present? castling.king_move_position
  end

  def rook_move_position_free?(castling)
    !figure_present? castling.rook_move_position
  end

  def through_move_position_free?(castling)
    !(castling.has_through? and figure_present? castling.through_position)
  end

  def figure_present?(position)
    @field.figure_present? position
  end

  def get_figure(position)
    @field.figure_by_position position
  end
end
