require 'spec_helper'
include Rchess

describe Rchess::CoveredCheckValidator do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:field) { field_factory.create_field fen_notation }
  let(:round_factory) { RoundFactory.new field }
  let(:turn) { Turn.new }
  let(:round) { round_factory.create_round turn }
  let(:covered_check_validator) { CoveredCheckValidator.new field }

  describe '#validate' do
    context 'when turn is white' do
      context 'when covered check is exists' do
        let(:fen_notation) { '1nb1k2r/2p3Pp/p2ppn2/1p2rP2/1qP4b/8/PP1BBNPP/R2QK2R' }

        it 'should create prohibition for moves with covered check' do
          covered_check_validator.validate turn, round
          prohibitions_num = 0

          round.white_move_collections.each do |mc|
            mc.moves.each { |move| prohibitions_num += 1 if move.has_prohibition? }
          end

          expect(prohibitions_num).to eql 14
        end
      end

      context 'when covered check does not exists' do
        let(:fen_notation) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR' }

        it 'should not create any prohibitions' do
          covered_check_validator.validate turn, round
          prohibitions_num = 0

          round.white_move_collections.each do |mc|
            mc.moves.each { |move| prohibitions_num += 1 if move.has_prohibition? }
          end

          expect(prohibitions_num).to eql 0
        end
      end
    end
  end
end

