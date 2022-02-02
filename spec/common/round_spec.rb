require 'common/round'
require 'common/move/move_collection'
require 'common/castling/castling'
require 'common/figure'
require 'common/figures/knight'
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

describe Round do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:field) { field_factory.create_field 'rnb1k2r/ppp2ppp/3b1n2/1B1pp1B1/3PP3/2N2N2/PPP2PPP/R21K2R' }
  let(:round_factory) { RoundFactory.new field }
  let(:round) { round_factory.create_round Turn.new }

  describe '.get_move_collections' do
    context 'when white color passed' do
      context 'when figure type was passed' do
        context 'when same figures are on the field' do
          it 'should return 2 move collections for passed figure type' do
            move_collections = round.get_move_collections ColorFactory.create_white, Knight
            expect(move_collections).to be_a Array
            expect(move_collections.length).to eql 2
            expect(move_collections.all? { |mc| mc.figure.is_a? Knight }).to be_truthy
          end
        end

        context 'when figure type is not on the field' do
          it 'should return empty Array' do
            move_collections = round.get_move_collections ColorFactory.create_white, Queen
            expect(move_collections).to be_a Array
            expect(move_collections.length).to eql 0
          end
        end
      end

      context 'when figure was not passed' do
        it 'should return array of move collections for all figures' do
          move_collections = round.get_move_collections ColorFactory.create_white
          expect(move_collections).to be_a Array
          expect(move_collections.length).to eql 15
        end
      end
    end
  end

  describe '.get_move_collection' do
    context 'when figure is on the field' do
      it 'should return move collection for passed figure' do
        figure = field.figure_by_position PositionFactory.create_by_notation 'c3'
        move_collection = round.get_move_collection figure
        expect(move_collection).to be_a MoveCollection
        expect(move_collection.figure.same? figure)
      end
    end

    context 'when figure is not on the field' do
      it 'should return nil' do
        figure = figure_factory.create_figure FenNotation::WHITE_QUEEN
        move_collection = round.get_move_collection figure
        expect(move_collection).to be_nil
      end
    end
  end

  describe '.get_castlings' do
    context 'when turn color is white' do
      context 'when passed color is white' do
        it 'should return array of castlings for white king' do
          castlings = round.get_castlings ColorFactory.create_white
          expect(castlings).to be_a Array
          expect(castlings.length).to eql 2
        end
      end

      context 'when passed color is black' do
        it 'should return array of castlings for black king' do
          castlings = round.get_castlings ColorFactory.create_black
          expect(castlings).to be_a Array
          expect(castlings.length).to eql 2
        end
      end
    end
  end
end