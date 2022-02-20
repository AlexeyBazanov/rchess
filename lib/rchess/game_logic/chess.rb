module Rchess
  class Chess
    class << self
      def start_new_party
        create_party_by_fen FenNotation::START_ARRANGEMENT
      end

      def continue_party(notation)
        create_party_by_fen notation
      end

      protected

      def create_party_by_fen(notation)
        factory = FenPartyFactory.new
        factory.create notation
      end
    end
  end
end