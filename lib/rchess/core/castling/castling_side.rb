module Rchess
  class CastlingSide
    QUEEN = 'queen'
    KING = 'king'

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def king?
      @name == KING
    end

    def queen?
      @name == QUEEN
    end
  end
end