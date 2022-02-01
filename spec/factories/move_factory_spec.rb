# TODO написать тесты после тестов классов Field и FieldFactory

require 'common/figure'
require 'common/figures/pawn'
require 'common/move/move'
require 'common/move/move_direction'
require 'common/position'
require 'common/field'
require 'factories/field/fen_field_factory'
require 'factories/move_factory'
require 'factories/position_factory'

describe MoveFactory do
  let(:field_factory) { FenFieldFactory.new FenFigureFactory.new  }
  let(:field) { field_factory.create_field FenNotation::START_ARRANGEMENT }
  let(:move_factory) { MoveFactory.new field }

  describe '#create_move' do
    subject { move_factory.create_move(
      PositionFactory.create_by_coordinates(0, 0),
      PositionFactory.create_by_coordinates(0, 6),
      direction: MoveDirectionFactory.create_up,
      barrier_figures: [field.figure_by_position(PositionFactory.create_by_coordinates(0, 1))])
    }

    it 'should return move' do
      expect(subject).to be_a Move
    end

    it 'should content direction' do
      expect(subject.direction).to be_a MoveDirection
    end

    it 'should content attacked figure' do
      expect(subject.attacked_figure).to be_a Pawn
    end

    it 'should content barrier figures array with one figure' do
      expect(subject.barrier_figures).to be_a Array
      expect(subject.barrier_figures.length).to eql 1
      expect(subject.barrier_figures.first).to be_a Pawn
    end
  end
end