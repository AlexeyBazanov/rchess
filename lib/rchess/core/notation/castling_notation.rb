module Rchess
  class CastlingNotation < AbstractNotation
    def initialize(castling)
      @sign = castling_to_sign castling
    end

    protected

    def castling_to_sign(castling)
      castling.has_through? ? FenNotation::QUEEN_CASTLING : FenNotation::KING_CASTLING
    end
  end
end