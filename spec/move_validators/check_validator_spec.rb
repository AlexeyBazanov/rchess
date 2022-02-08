# require 'spec_helper'

describe Rchess::CheckValidator do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:field) { field_factory.create_field fen_notation }
  let(:round_factory) { RoundFactory.new field }
  let(:turn) { Turn.new }
  let(:round) { round_factory.create_round turn }
  let(:check_validator) { CheckValidator.new field }

  describe '#validate' do
    context 'when turn is white' do
      context 'when check is exists' do
        context 'when king can be protected' do
          let(:fen_notation) { 'rnb1kbnr/pp2pppp/2p5/2Bp4/1q2P3/3P1N2/P1P2PPP/RN1QKB1R' }

          it 'should create move prohibition for all moves except king and defensive' do
            check_validator.validate turn, round
            possible_moves = 0
            round.white_move_collections.each { |mc| possible_moves += mc.possible_moves.length }
            expect(possible_moves).to eql 8
          end
        end

        context 'when king can not be protected' do
          let(:fen_notation) { 'rnb1kb1r/pp2pppp/2p5/2Bp4/1q2P3/3P1N2/PPP2PnP/RN1QKB1R' }

          it 'should create move prohibition for all moves except king' do
            check_validator.validate turn, round
            possible_moves = 0
            round.white_move_collections.each { |mc| possible_moves += mc.possible_moves.length }
            expect(possible_moves).to eql 2
          end
        end
      end

      context 'when check is not exists' do
        let(:fen_notation) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR' }

        it 'should not create any prohibitions' do
          check_validator.validate turn, round
          prohibitions = 0
          round.white_move_collections.each { |mc| prohibitions += mc.moves.count { |m| m.has_prohibition? } }
          expect(prohibitions).to eql 0
        end
      end
    end
  end
end