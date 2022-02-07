require 'common/turn'
require 'common/round'
require 'common/position'
require 'common/figure'
require 'common/move/move_collection'
require 'common/castling/castling'
require 'factories/figure/abstract_figure_factory'
require 'factories/figure/fen_figure_factory'
require 'factories/field/abstract_field_factory'
require 'factories/field/fen_field_factory'
require 'factories/position_factory'
require 'factories/color_factory'
require 'factories/move_collection/move_collection_factory'
require 'factories/move_collection/pawn_move_collection_factory'
require 'factories/move_collection/king_move_collection_factory'
require 'factories/move_collection/queen_move_collection_factory'
require 'factories/move_collection/bishop_move_collection_factory'
require 'factories/move_collection/knight_move_collection_factory'
require 'factories/move_collection/rook_move_collection_factory'
require 'factories/move_collection/move_collections_factory'
require 'factories/round_factory'
require 'move_validators/move_validator'
require 'move_validators/castling_validator'

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