module Rchess
  class FenPartyFactory < AbstractPartyFactory
    def initialize
      @field_factory = FenFieldFactory.new(FenFigureFactory.new)
    end

    def create(fen_notation)
      field = @field_factory.create_field fen_notation
      turn = Turn.new
      round_factory = RoundFactory.new field
      Party.new field, turn, round_factory
    end
  end
end