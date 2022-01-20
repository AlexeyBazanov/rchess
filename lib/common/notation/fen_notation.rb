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

    def position_to_coordinates(notation)
      unless notation.is_a? String
        raise ArgumentError.new('Notation must be a string')
      end

      unless notation.length == 2
        raise ArgumentError.new('Notation string length must be equal 2')
      end

      x = LETTERS.index notation[0].to_i
      y = notation[1].to_i - 1

      raise ArgumentError.new('Invalid x coordinate') if x.nil?
      raise ArgumentError.new('Invalid y coordinate') unless y.between?(0, 7)

      [x, y]
    end
  end
end