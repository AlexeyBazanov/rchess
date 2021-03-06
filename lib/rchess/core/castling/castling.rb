module Rchess
  class Castling
    attr_reader :king_move, :rook_move, :side, :through_position, :required_positions, :notation
    attr_accessor :prohibition

    def initialize(king_move, rook_move, side, through_position)
      @king_move = king_move
      @rook_move = rook_move
      @side = side
      @through_position = through_position
      @notation = CastlingNotation.new self
      initialize_required_positions
    end

    def possible?
      @prohibition.nil?
    end

    def has_through?
      @through_position.is_a? Position
    end

    def king_position
      @king_move.position_from
    end

    def rook_position
      @rook_move.position_from
    end

    def king_move_position
      @king_move.position_to
    end

    def rook_move_position
      @rook_move.position_to
    end

    def get_moves
      [@king_move, @rook_move]
    end

    def do(field)
      get_moves.each { |move| move.do(field) }
    end

    def undo(field)
      get_moves.each { |move| move.undo(field) }
    end

    private

    def initialize_required_positions
      @required_positions = [
        @king_move.position_from, @king_move.position_to,
        @rook_move.position_from, @rook_move.position_to
      ]
      @required_positions.push(@through_position) if @through_position.is_a? Position
    end
  end
end