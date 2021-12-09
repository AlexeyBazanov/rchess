class Castling
  attr_reader :king_move, :rook_move, :side, :though_position, :required_positions
  attr_accessor :prohibition

  def initialize(king_move, rook_move, side, through_position)
    @king_move = king_move
    @rook_move = rook_move
    @side = side
    @though_position = through_position
    initialize_required_positions
  end

  def possible?
    @prohibition.nil?
  end

  def has_through?
    @though_position.is_a? Position
  end

  private

  def initialize_required_positions
    @required_positions = [
      @king_move.position_from, @king_move.position_to,
      @rook_move.position_from, @rook_move.position_to
    ]
    @required_positions.push(@though_position) if @though_position.is_a? Position
  end
end