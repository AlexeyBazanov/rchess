module Rchess
  class Notation
    START_ARRANGEMENT = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
    FIGURES = 'rnbqkbnrpRNBQKBNRP'
    COORDINATES = '12345678'
    NEW_LINE = '/'

    NUMBERS = [0, 1, 2, 3, 4, 5, 6, 7]
    LETTERS = %w[a b c d e f g h]

    MIN = 1
    MAX = 2

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
      def parse_position(x, y)
        "#{LETTERS.at(x)}#{y+1}"
      end

      def figure?(notation)
        FIGURES.include? notation
      end

      def new_line?(notation)
        notation == NEW_LINE
      end

      def coordinate?(notation)
        COORDINATES.include? notation
      end

      def parse_move(notation)
        return nil unless notation.is_a? String or not notation.length.between? MIN, MAX
        x = NUMBERS.at(char_to_int(notation, 0))
        y = char_to_int(notation, 1) - 1
        [x, y]
      end

      private

      def char_to_int(string, char_pos)
        string[char_pos].to_i
      end
    end
  end
end
