class FenNotation
  START_ARRANGEMENT = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
  FIGURES = 'rnbqkbnrpRNBQKBNRP'
  COORDINATES = '12345678'
  NUMBERS = [0, 1, 2, 3, 4, 5, 6, 7]
  LETTERS = %w[a b c d e f g h]
  NEW_LINE = '/'
  WHITE_MOVE = 'w'
  BLACK_MOVE = 'b'
  KING_SIGNS = %w[K k]
  QUEEN_SIGNS = %w[Q q]
  BISHOP_SIGNS = %w[B b]
  KNIGHT_SIGNS = %w[N n]
  ROOK_SIGNS = %w[R r]
  PAWN_SIGNS = %w[P p]
  WHITE_KING = 'K'
  BLACK_KING = 'k'
  WHITE_QUEEN = 'Q'
  BLACK_QUEEN = 'q'
  WHITE_BISHOP = 'B'
  BLACK_BISHOP = 'b'
  WHITE_KNIGHT = 'N'
  BLACK_KNIGHT = 'n'
  WHITE_ROOK = 'R'
  BLACK_ROOK = 'r'
  WHITE_PAWN = 'P'
  BLACK_PAWN = 'p'

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