module Rchess
  class CoveredCheckValidator < MoveValidator
    def validate(turn, round)
      current_side_move_collections = round.get_move_collections turn.color
      opposite_side_move_collections = round.get_move_collections turn.color.opposite
      covered_check_moves = collect_covered_check_moves opposite_side_move_collections

      puts "Covered check moves - #{covered_check_moves.length}"

      return if covered_check_moves.length.zero?

      validate_barrier_figures_moves covered_check_moves, current_side_move_collections
    end

    private

    def collect_covered_check_moves(move_collections)
      covered_check_moves = []
      move_collections.each do |move_collection|
        covered_check_move = move_collection.covered_check_move
        covered_check_moves.push covered_check_move unless covered_check_move.nil?
      end
      covered_check_moves
    end

    def validate_barrier_figures_moves(covered_check_moves, move_collections)
      move_collections.each do |move_collection|
        covered_check_moves.each do |covered_check_move|
          if covered_check_move.blocked_by? move_collection.figure
            validate_barrier_figure_moves covered_check_move, move_collection
          end
        end
      end
    end

    def validate_barrier_figure_moves(covered_check_move, move_collection)
      move_collection.possible_moves.each do |barrier_figure_move|
        is_on_way = covered_check_move.intersect? barrier_figure_move.position_to
        can_attack = barrier_figure_move.attack_to? covered_check_move.figure

        prohibit_move barrier_figure_move unless is_on_way || can_attack
      end
    end

    def prohibit_move(move)
      move.prohibit! MoveProhibitionFactory.create_covered_check
    end
  end
end