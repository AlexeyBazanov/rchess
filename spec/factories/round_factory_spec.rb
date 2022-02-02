require 'common/round'
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

describe RoundFactory do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:field) { field_factory.create_field 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR' }
  let(:round_factory) { RoundFactory.new field }

  describe '.create_round' do
    context 'when white turn passed' do
      subject { round_factory.create_round Turn.new }

      it 'should create round' do
        expect(subject).to be_a Round
      end

      it 'should content white moves collections for all figures' do
        expect(subject.white_move_collections).to be_a Array
        expect(subject.black_move_collections.length).to eql 16
        expect(subject.white_move_collections.all? { |item| item.is_a? MoveCollection }).to be_truthy
      end

      it 'should content black moves collections for all figures' do
        expect(subject.black_move_collections).to be_a Array
        expect(subject.black_move_collections.length).to eql 16
        expect(subject.white_move_collections.all? { |item| item.is_a? MoveCollection }).to be_truthy
      end

      it 'should content white castlings' do
        expect(subject.white_castlings).to be_a Array
        expect(subject.white_castlings.length).to eql 2
        expect(subject.white_castlings.all? { |item| item.is_a? Castling }).to be_truthy
      end

      it 'should content black castlings' do
        expect(subject.black_castlings).to be_a Array
        expect(subject.black_castlings.length).to eql 2
        expect(subject.black_castlings.all? { |item| item.is_a? Castling }).to be_truthy
      end
    end
  end
end