# frozen_string_literal: true

module Rchess
  class KingMoveValidator < MoveValidator
    def validate(turn, round)
      current_color = turn.color
      opposite_color = current_color.opposite
      king = @field.figure_by_type King, current_color
      king_move_collection = round.get_move_collection king
      opposite_move_collections = round.get_move_collections opposite_color

      validate_king_move_collection king_move_collection, opposite_move_collections if king_move_collection
    end

    private

    def validate_king_move_collection(king_move_collection, opposite_move_collections)
      king_move_collection.possible_moves.each do |move|
        validate_king_move move, opposite_move_collections
      end
    end

    def validate_king_move(king_move, opposite_move_collections)
      if king_move.has_attacked_figure?
        validate_attack_move king_move, opposite_move_collections
      else
        validate_silent_move king_move, opposite_move_collections
      end
    end

    def validate_attack_move(king_move, opposite_move_collections)
      opposite_move_collections.each do |move_collection|
        if move_collection.has_attack_to_figure? king_move.attacked_figure
          king_move.prohibit! MoveProhibitionFactory.create_check_king_move
          break
        end
      end
    end

    def validate_silent_move(king_move, opposite_move_collections)
      opposite_move_collections.each do |move_collection|
        opposite_move = move_collection.move_by_destination_position king_move.position_to

        next unless opposite_move

        is_move_barrier_by_king = opposite_move.one_opposite_figure_barrier? and
          opposite_move.blocked_by? king_move.figure

        if opposite_move.possible? || is_move_barrier_by_king
          king_move.prohibit! MoveProhibitionFactory.create_check_king_move
          break
        end
      end
    end
  end
end
