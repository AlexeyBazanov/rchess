module Rchess
  class CheckValidator < MoveValidator
    def validate(turn, round)
      current_side_move_collections = round.get_move_collections turn.color
      opposite_side_move_collections = round.get_move_collections turn.color.opposite
      check_moves = collect_check_moves opposite_side_move_collections

      return if check_moves.length.zero?

      if can_defend? check_moves
        prohibit_all_except_king_and_defence check_moves.first, current_side_move_collections
      else
        prohibit_all_except_king current_side_move_collections
      end
    end

    private

    def can_defend?(check_moves)
      check_moves.length <= 1
    end

    def collect_check_moves(move_collections)
      check_moves = []
      move_collections.each do |move_collection|
        check_move = move_collection.check_move
        check_moves.push check_move unless check_move.nil?
      end
      check_moves
    end

    def prohibit_all_except_king(move_collections)
      exclude_king_moves(move_collections) do |move_collection|
        move_collection.prohibit_moves(get_move_prohibition)
      end
    end

    def prohibit_all_except_king_and_defence(check_move, move_collections)
      puts "\n"
      exclude_king_moves(move_collections) do |move_collection|
        move_collection.prohibit_moves(get_move_prohibition) do |moves|
          get_defencive_moves check_move, moves
        end
      end
    end

    def get_defencive_moves(check_move, moves)
      moves.reject { |move| check_move.intersect?(move.position_to) || move.attack_to?(check_move.figure) }
    end

    def exclude_king_moves(move_collections)
      move_collections.each do |move_collection|
        next if move_collection.figure.is_a? King
        yield move_collection
      end
    end

    def get_move_prohibition
      MoveProhibitionFactory.create_king_under_attack
    end
  end
end