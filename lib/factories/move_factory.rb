class MoveFactory
  attr_reader :field

  def initialize(field)
    @field = field
  end

  def create_move(position_from, position_to, direction: nil, barrier_figures: [], prev_moves: [])
    figure = @field.figure_by_position position_from
    return if figure.nil?

    move = Move.new figure, position_from, position_to, direction
    move.barrier_figures = barrier_figures
    move.prev_moves = prev_moves
    move.attacked_figure = field.figure_by_position position_to
    move
  end
end