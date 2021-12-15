class PawnMoveValidator < MoveValidator
  def validate(turn, round)
    opposite_side_pawns = field.figures(turn.color.opposite, Pawn)
    current_side_move_collections = round.get_move_collections turn.color, Pawn
    opposite_side_move_collections = round.get_move_collections turn.color.opposite, Pawn

    validate_current_side_moves current_side_move_collections, opposite_side_pawns
    validate_opposite_side_moves opposite_side_move_collections
  end

  private

  def validate_current_side_moves(move_collections, opposite_pawns)
    iterate_possible_moves(move_collections) do |move|
      if move.direction.diagonal?
        validate_attacking_move move, opposite_pawns
      else
        validate_silent_move move
      end
    end
  end

  def validate_opposite_side_moves(move_collections)
    iterate_possible_moves(move_collections) do |move|
      if move.direction.vertical?
        prohibit_move move
      end
    end
  end

  def iterate_possible_moves(move_collections)
    move_collections.each do |move_collection|
      move_collection.possible_moves.each do |move|
        yield move
      end
    end
  end

  def validate_attacking_move(move, opposite_side_pawns)
    return if move.has_attacked_figure?

    opposite_side_pawns.each do |opposite_pawn|
      if suitable_for_taking_on_pass? move, opposite_pawn
        move.attacked_figure = opposite_pawn
        return
      end
    end

    prohibit_move move
  end

  def validate_silent_move(move)
    prohibit_move move if move.has_attacked_figure?
  end

  def suitable_for_taking_on_pass?(pawn_move, opposite_pawn)
      opposite_pawn.can_be_taking_on_pass &&
        opposite_pawn.position.same_x?(pawn_move.position_to) &&
        opposite_pawn.position.nearby_y?(pawn_move.position_to)
  end

  def prohibit_move(move)
    move.prohibit! MoveProhibitionFactory.create_incorrect_pawn_move
  end
end