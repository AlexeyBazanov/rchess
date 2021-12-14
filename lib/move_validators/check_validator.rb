class CheckValidator < MoveValidator
  def validate(turn, round)
    current_side_move_collections = round.get_move_collections turn.color
    opposite_side_move_collections = round.get_move_collections turn.color.opposite
    check_moves = collect_check_moves opposite_side_move_collections

    return if check_moves.length.zero?

    if can_defend? check_moves
      prohibit_all_except_defend_and_king check_moves.first, current_side_move_collections
    else
      prohibit_all_except_king current_side_move_collections
    end
  end

  private

  def collect_check_moves(move_collections)
    check_moves = []
    move_collections.each do |move_collection|
      check_move = move_collection.check_move
      check_moves.push check_move unless check_move.nil?
    end
    check_moves
  end

  def can_defend?(check_moves)
    check_moves.length == 1
  end

  def prohibit_all_except_king(move_collections)
    each_move_collections_except_king(move_collections) do |move_collection|
      move_collection.prohibit_moves(move_prohibition)
    end
  end

  def prohibit_all_except_defend_and_king(check_move, move_collections)
    each_move_collections_except_king(move_collections) do |move_collection|
      move_collection.prohibit_moves(move_prohibition) do |moves|
        moves.reject { |move| move.intersect?(check_move.position_to) || move.can_attack? }
      end
    end
  end

  def each_move_collections_except_king(move_collections)
    move_collections.each do |move_collection|
      next if move_collection.figure.is_a? King

      yield move_collection
    end
  end

  def move_prohibition
    MoveProhibitionFactory.create_king_under_attack
  end
end