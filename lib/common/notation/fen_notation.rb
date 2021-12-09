class FenNotation
  START_ARRANGEMENT = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
  FIGURES = 'rnbqkbnrpRNBQKBNRP'
  COORDINATES = '12345678'
  NEW_LINE = '/'
  WHITE_MOVE = 'w'
  BLACK_MOVE = 'b'
  KING_SIGNS = %w[K k]
  QUEEN_SIGNS = %w[Q q]
  BISHOP_SIGNS = %w[B b]
  KNIGHT_SIGNS = %w[N n]
  ROOK_SIGNS = %w[R r]
  PAWN_SIGNS = %w[P p]

  class << self
    def figure?(notation)
      FIGURES.include? notation
    end

    def new_line?(notation)
      notation == NEW_LINE
    end

    def coordinate?(notation)
      COORDINATES.include? notation
    end
  end
end