class CastlingSideFactory
  class << self
    def create_king_side
      CastlingSide.new CastlingSide::KING
    end

    def create_queen_side
      CastlingSide.new CastlingSide::QUEEN
    end
  end
end