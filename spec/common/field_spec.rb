require 'common/position'
require 'common/color'
require 'common/figure'
require 'common/cell'
require 'common/field'
require 'common/figures/king'
require 'common/figures/pawn'
require 'factories/figure/abstract_figure_factory'
require 'factories/figure/fen_figure_factory'
require 'factories/color_factory'

describe Field do
  let(:field) { Field.new }
  let(:figure_factory) { FenFigureFactory.new }

  before(:each) do
    white_pawn = figure_factory.create_figure FenNotation::WHITE_PAWN
    white_king = figure_factory.create_figure FenNotation::WHITE_KING
    black_king = figure_factory.create_figure FenNotation::BLACK_KING

    field.set_figure white_king, Position.new(0, 4)
    field.set_figure white_pawn, Position.new(1, 5)
    field.set_figure black_king, Position.new(7, 4)
  end

  describe '#initialize' do
    it 'should have matrix with 64 Cell class instances' do
      expect(field.cells).to be_a Array
      expect(field.cells.flatten.count { |cell| cell.is_a? Cell}).to eql 64
    end
  end

  describe '#cell_by_position' do
    it 'should return Cell class instance' do
      position = Position.new(1,1)
      expect(field.cell_by_position position).to be_a Cell
    end
  end

  describe '#figures' do
    context 'when no additional params were passed' do
      it 'should return all figures' do
        expect(field.figures.length).to eql 3
      end
    end

    context 'when color was passed' do
      it 'should return only figures with passed color' do
        expect(field.figures(color: ColorFactory.create_white).length).to eql 2
        expect(field.figures(color: ColorFactory.create_black).length).to eql 1
      end
    end

    context 'when type was passed' do
      it 'should return only figures with passed type' do
        expect(field.figures(class_type: King).length).to eql 2
        expect(field.figures(class_type: Pawn).length).to eql 1
      end
    end
  end

  describe '#figure_present?' do
    context 'when figure in cell with passed position exists' do
      it 'should return true' do
        expect(field.figure_present? Position.new(0,4)).to eql true
      end
    end

    context 'when figure in cell with passed position doesnt exists' do
      it 'should return false' do
        expect(field.figure_present? Position.new(5,5)).to eql false
      end
    end
  end

  describe '#figure_by_position' do
    context 'when figure in cell with passed position exists' do
      it 'should return figure' do
        expect(field.figure_by_position Position.new(0,4)).to be_a King
      end
    end

    context 'when figure in cell with passed position doesnt exists' do
      it 'should return nil' do
        expect(field.figure_by_position Position.new(5,5)).to eql nil
      end
    end
  end

  describe '#move_figure' do
    context 'when figure in cell with passed position exists' do
      it 'should move figure to passed position and increase figure moves' do
        position_from = Position.new(0,4)
        position_to = Position.new(0,5)
        figure = field.figure_by_position position_from
        field.move_figure position_from, position_to

        expect(field.figure_present? position_from).to eql false
        expect(field.figure_by_position position_to).to be_a figure.class
        expect(figure.moves_count).to eql 1
      end
    end

    context 'when figure in cell with passed position doesnt exists' do
      it 'should return nil' do
        expect(field.move_figure Position.new(5,5), Position.new(5,6)).to eql nil
      end
    end
  end
end