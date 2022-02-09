require 'spec_helper'
include Rchess

describe Rchess::KingMoveValidator do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:field) { field_factory.create_field fen_notation }
  let(:round_factory) { RoundFactory.new field }
  let(:turn) { Turn.new }
  let(:round) { round_factory.create_round turn }
  let(:king_move_validator) { KingMoveValidator.new field }

  describe '#validate' do
    context 'when turn is white' do
      context 'when invalid moves is exist' do
        let(:fen_notation) { 'rn2kb1r/p1p3pp/bp4n1/8/4K3/5P1P/PPPPP1P1/RNBQ1BNR' }

        it 'should create move prohibitions' do
          king_move_validator.validate turn, round
          prohibitions_num = 0
          king_position = PositionFactory.create_by_notation 'e4'
          king_move_collection = round.get_move_collection field.figure_by_position king_position

          if king_move_collection
            king_move_collection.moves.each { |move| prohibitions_num += 1 if move.has_prohibition? }
          end

          expect(prohibitions_num).to eql 3
        end
      end
    end
  end
end