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
      let(:fen_notation) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR' }

      it 'should validate white side castlings' do
        castling_validator.validate turn, round
        castlings = round.get_castlings ColorFactory.create_white

        expect(castlings).to be_a Array
      end
    end

  end
end