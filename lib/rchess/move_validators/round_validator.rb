module Rchess
  class RoundValidator < MoveValidator
    attr_reader :pawn_move_validator,
                :king_move_validator,
                :check_validator,
                :covered_check_validator,
                :castling_validator

    def initialize(field)
      super(field)
      @pawn_move_validator = PawnMoveValidator.new field
      @king_move_validator = KingMoveValidator.new field
      @check_validator = CheckValidator.new field
      @covered_check_validator = CoveredCheckValidator.new field
      @castling_validator = CastlingValidator.new field
    end

    def validate(turn, round)
      @pawn_move_validator.validate turn, round
      @king_move_validator.validate turn, round
      @check_validator.validate turn, round
      @covered_check_validator.validate turn, round
      @castling_validator.validate turn, round
    end
  end
end