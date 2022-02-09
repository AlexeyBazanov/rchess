require 'spec_helper'
include Rchess

describe Move do
  let(:figure_factory) { FenFigureFactory.new }
  let(:white_bishop) { figure_factory.create_figure FenNotation::WHITE_BISHOP }
  let(:black_bishop) { figure_factory.create_figure FenNotation::BLACK_BISHOP }
  let(:top_left_direction) { MoveDirectionFactory.create_top_left }
  let(:top_right_direction) { MoveDirectionFactory.create_top_right }
  let(:first_move) {
    Move.new(
      white_bishop,
      PositionFactory.create_by_notation('f1'),
      PositionFactory.create_by_notation('b5'),
      top_left_direction
    )
  }
  let(:second_move) {
    Move.new(
      white_bishop,
      PositionFactory.create_by_notation('b5'),
      PositionFactory.create_by_notation('d7'),
      top_right_direction
    )
  }

  describe '#move_set' do
    context 'when 1 previous move exists' do
      it 'should have two moves in move set' do
        second_move.prev_moves << first_move
        expect(second_move.move_set.length).to eql 2
      end
    end

    context 'when previous moves doesnt exists' do
      it 'should have one move in move set' do
        expect(second_move.move_set.length).to eql 1
      end
    end
  end

  describe '#blocked_by?' do
    context 'when move block by given figure' do
      it 'should return true' do
        black_bishop.position = first_move.position_to
        first_move.barrier_figures << black_bishop
        expect(first_move.blocked_by? black_bishop).to eql true
      end
    end

    context 'when move doesnt block by given figure' do
      it 'should return false' do
        black_bishop.position = Position.new(1,1)
        expect(first_move.blocked_by? black_bishop).to eql false
      end
    end
  end

  describe '#one_opposite_figure_barrier?' do
    context 'when move has only one barrier figure' do
      context 'when barrier figure color is opposite' do
        it 'should return true' do
          first_move.barrier_figures << black_bishop
          expect(first_move.one_opposite_figure_barrier?).to eql true
        end

        context 'when barrier figure color is same' do
          it 'should return false' do
            first_move.barrier_figures << white_bishop
            expect(first_move.one_opposite_figure_barrier?).to eql false
          end
        end
      end
    end

    context 'when the quantity of barrier figures is not equal to one' do
      it 'should return false' do
        expect(first_move.one_opposite_figure_barrier?).to eql false
      end
    end
  end

  describe '#attacked_figure_opposite?' do
    context 'when move has attacked figure' do
      context 'when attacked figure color is opposite' do
        it 'should return true' do
          first_move.attacked_figure = black_bishop
          expect(first_move.attacked_figure_opposite?).to eql true
        end
      end

      context 'when attacked figure color is same' do
        it 'should return false' do
          first_move.attacked_figure = white_bishop
          expect(first_move.attacked_figure_opposite?).to eql false
        end
      end
    end

    context 'when move doesnt has attacked figure' do
      it 'should return false' do
        expect(first_move.attacked_figure_opposite?).to eql false
      end
    end
  end

  describe '#can_attack?' do
    context 'when move has attacked figure' do
      context 'when attacked figure color is opposite' do
        context 'when barrier figures doesnt exists' do
          it 'should return true' do
            first_move.attacked_figure = black_bishop
            expect(first_move.can_attack?).to eql true
          end
        end

        context 'when barrier figures exist' do
          it 'should return false' do
            first_move.attacked_figure = black_bishop
            first_move.barrier_figures << black_bishop
            expect(first_move.can_attack?).to eql false
          end
        end
      end

      context 'when attacked figure color is same' do
        it 'should return false' do
          first_move.attacked_figure = white_bishop
          expect(first_move.can_attack?).to eql false
        end
      end
    end

    context 'when move doesnt has attacked figure' do
      it 'should return false' do
        expect(first_move.can_attack?).to eql false
      end
    end
  end

  describe '#check?' do
    context 'when attacked figure exists' do
      context 'when attacked figure is opposite king' do
        it 'should return true' do
          first_move.attacked_figure = figure_factory.create_figure FenNotation::BLACK_KING
          expect(first_move.check?).to eql true
        end
      end

      context 'when attacked figure is another' do
        it 'should return false' do
          first_move.attacked_figure = black_bishop
          expect(first_move.check?).to eql false
        end
      end
    end

    context 'when attacked figure doesnt exists' do
      it 'should return false' do
        expect(first_move.check?).to eql false
      end
    end
  end

  describe '#can_attack?' do
    # TODO
  end

  describe '#covered_check?' do
    # TODO
  end

  describe '#possible?' do
    context 'when move has attacked figure' do
      context 'when attacked figure color is opposite' do
        it 'should return true' do
          first_move.attacked_figure = black_bishop
          expect(first_move.possible?).to eql true
        end
      end

      context 'when attacked figure color is same' do
        it 'should return false' do
          first_move.attacked_figure = white_bishop
          expect(first_move.possible?).to eql false
        end
      end

      context 'when move has barrier figures' do
        it 'should return false' do
          first_move.attacked_figure = black_bishop
          first_move.barrier_figures << black_bishop
          expect(first_move.possible?).to eql false
        end
      end
    end

    context 'when move doesnt has attacked figure' do
      context 'when move doesnt has barrier figures and prohibition' do
        it 'should return true' do
          expect(first_move.possible?).to eql true
        end
      end

      context 'when move has barrier figures' do
        it 'should return false' do
          first_move.barrier_figures << black_bishop
          expect(first_move.possible?).to eql false
        end
      end

      context 'when move has prohibition' do
        it 'should return false' do
          first_move.prohibit! MoveProhibitionFactory.create_king_under_attack
          expect(first_move.possible?).to eql false
        end
      end
    end
  end

  describe '#intersect?' do
    before(:each) do
      prev_move_one = Move.new(
        white_bishop,
        PositionFactory.create_by_notation('f1'),
        PositionFactory.create_by_notation('e2'),
        top_left_direction
      )

      prev_move_two = Move.new(
        white_bishop,
        PositionFactory.create_by_notation('f1'),
        PositionFactory.create_by_notation('d3'),
        top_left_direction
      )

      prev_move_three = Move.new(
        white_bishop,
        PositionFactory.create_by_notation('f1'),
        PositionFactory.create_by_notation('c4'),
        top_left_direction
      )

      first_move.prev_moves = [prev_move_one, prev_move_two, prev_move_three]
    end

    it 'should return true if given position intersect positions of prev moves' do
      expect(first_move.intersect? PositionFactory.create_by_notation('e2')).to be_truthy
      expect(first_move.intersect? PositionFactory.create_by_notation('d3')).to be_truthy
      expect(first_move.intersect? PositionFactory.create_by_notation('c4')).to be_truthy
    end

    it 'should return false if given position doesn`t intersect positions of prev moves' do
      expect(first_move.intersect? PositionFactory.create_by_notation('g4')).to be_falsey
      expect(first_move.intersect? PositionFactory.create_by_notation('h8')).to be_falsey
      expect(first_move.intersect? PositionFactory.create_by_notation('c1')).to be_falsey
    end
  end
end