# frozen_string_literal: true

class CastlingValidator < MoveValidator

  def validate(turn, round)
    current_side_castlings = round.get_castlings turn.color
    opposite_move_collections = round.get_move_collections turn.color.opposite

    current_side_castlings.each do |castling|
      validate_castling castling, opposite_move_collections
    end
  end

  private

  def validate_castling(castling, opposite_move_collections)
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

    if cells_under_attack? castling, opposite_move_collections
      castling.prohibition = MoveProhibitionFactory.create_cell_is_under_attack
      return false
    end

    true
  end

  def cells_under_attack?(castling, opposite_move_collections)
    opposite_move_collections.each do |move_collection|
      castling.required_positions.each do |castling_position|
        return true if move_collection.can_move_to? castling_position
      end
    end

    false
  end

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
