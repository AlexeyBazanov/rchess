class MoveCollection
  attr_reader :figure, :moves

  def initialize(figure, moves=[])
    @figure = figure
    @moves = moves
  end

  def check_move
    @moves.find { |move| move.check? and move.possible? }
  end

  def covered_check_move
    @moves.find { |move| move.covered_check? }
  end

  def possible_moves
    @moves.select { |move| move.possible? }
  end

  def move_by_destination_position(position)
    moves.each do |move|
      return move if move.position_to.same? position
    end
    nil
  end

  def has_attack_to_figure?(figure)
    moves.each do |move|
      next unless move.has_attacked_figure?
      next if move.has_barrier_figures?
      return true if move.attacked_figure.same? figure
    end
    false
  end

  def prohibit_moves(move_prohibition)
    moves = possible_moves
    moves = yield moves if block_given?
    moves.each { |move| move.prohibit! move_prohibition }
  end
end