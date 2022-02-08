require 'spec_helper'

describe CastlingValidator do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:field) { field_factory.create_field fen_notation }
  let(:round_factory) { RoundFactory.new field }
  let(:turn) { Turn.new }
  let(:round) { round_factory.create_round turn }
  let(:castling_validator) { CastlingValidator.new field }

  describe '.validate' do
    context 'when turn is white' do
      context 'when arrangement with no space for castlings was used' do
        let(:fen_notation) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR' }

        it 'should create move prohibitions for short and long castlings' do
          castling_validator.validate turn, round
          castlings = round.get_castlings ColorFactory.create_white

          expect(castlings.all? {|c| c.prohibition.is_a? MoveProhibition }).to be_truthy
        end
      end

      context 'when arrangement with attack to castlings positions was used' do
        let(:fen_notation) { 'rnbqkb1r/pppppppp/8/3N2B1/2B1P1Q1/3Pn2N/PPP2PPP/R3K2R' }

        it 'should create move prohibitions for short and long castlings' do
          castling_validator.validate turn, round
          castlings = round.get_castlings ColorFactory.create_white

          expect(castlings.all? {|c| c.prohibition.is_a? MoveProhibition }).to be_truthy
        end
      end

      context 'when arrangement with check was used' do
        let(:fen_notation) { 'rnb1kbnr/pp1ppppp/8/q1pN2B1/2B1P1Q1/3P3N/PPP2PPP/R3K2R' }

        it 'should create move prohibitions for short and long castlings' do
          castling_validator.validate turn, round
          castlings = round.get_castlings ColorFactory.create_white

          expect(castlings.all? {|c| c.prohibition.is_a? MoveProhibition }).to be_truthy
        end
      end

      context 'when figures already been moved' do
        let(:fen_notation) { 'rnbqkbnr/pppppppp/8/3N2B1/2B1P1Q1/3P3N/PPP2PPP/R3K2R' }

        it 'should create move prohibitions for short and long castlings' do
          king = field.figure_by_position PositionFactory.create_by_notation 'e1'
          king.increase_moves

          castling_validator.validate turn, round
          castlings = round.get_castlings ColorFactory.create_white

          expect(castlings.all? {|c| c.prohibition.is_a? MoveProhibition }).to be_truthy
        end
      end

      context 'when suitable for castlings arrangement was used' do
        let(:fen_notation) { 'rnbqkbnr/pppppppp/8/3N2B1/2B1P1Q1/3P3N/PPP2PPP/R3K2R' }

        it 'should not create move prohibitions for short and long castlings' do
          castling_validator.validate turn, round
          castlings = round.get_castlings ColorFactory.create_white

          expect(castlings.all? {|c| c.prohibition.nil? }).to be_truthy
        end
      end
    end
  end
end