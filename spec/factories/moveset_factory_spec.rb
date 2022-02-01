require 'common/field'
require 'common/figures/pawn'
require 'common/figures/rook'
require 'common/figures/queen'
require 'common/figures/knight'
require 'common/move/move'
require 'common/notation/fen_notation'
require 'factories/move_factory'
require 'factories/moveset_factory'
require 'factories/field/fen_field_factory'
require 'factories/position_factory'

describe MovesetFactory do
  let(:field_factory) { FenFieldFactory.new FenFigureFactory.new  }
  let(:field) { field_factory.create_field FenNotation::START_ARRANGEMENT }
  let(:move_factory) { MoveFactory.new field }
  let(:moveset_factory) { MovesetFactory.new move_factory }

  describe '.create_by_direction' do
    context 'when move direction is up, cells limit is 7 and figure is white left rook on it`s start position' do
      subject { moveset_factory.create_by_direction(
        PositionFactory.create_by_notation('a1'),
        MoveDirectionFactory.create_up,
        cells_limit: 7)
      }

      it 'should return array with 7 Move objects' do
        expect(subject).to be_a Array
        expect(subject.length).to eql 7
        expect(subject.all? { |item| item.is_a? Move }).to eql true
      end

      it 'should content last move with previous six moves' do
        last_move = subject.last
        expect(last_move.prev_moves).to be_a Array
        expect(last_move.prev_moves.length).to eql 6
      end

      it 'should content last move with barrier figures collection with two pawns' do
        last_move = subject.last
        expect(last_move.barrier_figures).to be_a Array
        expect(last_move.barrier_figures.length).to eql 2
        expect(last_move.barrier_figures.all? { |item| item.is_a? Pawn }).to eql true
      end

      it 'should content last move with attack on opposite Rook' do
        last_move = subject.last
        expect(last_move.attacked_figure).to be_a Rook
      end
    end
  end

  describe '.create_by_directions' do
    context 'when all directions passed, cells limit is 7 and figure is white queen on it`s start position' do
      subject { moveset_factory.create_by_directions(
        PositionFactory.create_by_notation('d1'),
        MoveDirectionFactory.create_all,
        cells_limit: 7)
      }

      it 'should return array with 21 Move objects' do
        expect(subject).to be_a Array
        expect(subject.length).to eql 21
        expect(subject.all? { |item| item.is_a? Move }).to eql true
      end
    end
  end

  describe '.create_by_offsets' do
    context 'when figure is white left horse on it`s start position and offsets are 1 and 2' do
      subject { moveset_factory.create_by_offsets(
        PositionFactory.create_by_notation('b1'),
        axis_one_offset: 1,
        axis_two_offset: 2)
      }

      it 'should return array with 3 Moves objects' do
        expect(subject).to be_a Array
        expect(subject.length).to eql 3
        expect(subject.all? { |item| item.is_a? Move }).to eql true
      end
    end

    context 'when figure is white left horse on C3' do
      it 'should return array with 8 Moves objects' do
        field.move_figure PositionFactory.create_by_notation('b1'), PositionFactory.create_by_notation('c3')

        moves = moveset_factory.create_by_offsets(
          PositionFactory.create_by_notation('c3'),
          axis_one_offset: 1,
          axis_two_offset: 2
        )

        expect(moves).to be_a Array
        expect(moves.length).to eql 8
        expect(moves.all? { |item| item.is_a? Move }).to eql true
      end
    end
  end
end