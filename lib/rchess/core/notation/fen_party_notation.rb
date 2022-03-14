module Rchess
  class FenPartyNotation < AbstractNotation
    def initialize(party)
      @sign = party_to_sign party
    end

    protected

    def party_to_sign(party)
      sign = ''
      sign += party.white_move? ? FenNotation::WHITE_MOVE : FenNotation::BLACK_MOVE
      sign += ' '

    end
  end
end