require 'factories/field/abstract_field_factory'
require 'factories/field/fen_field_factory'
require 'common/notation/fen_notation'
require 'common/field'
require 'common/figures/rook'
require 'common/figures/knight'
require 'common/figures/bishop'
require 'common/figures/queen'
require 'common/figures/king'
require 'common/figures/pawn'

describe FenFieldFactory do
  let(:field_factory) { FenFieldFactory.new FenFigureFactory.new  }

  describe '#create_field' do
    context 'when fen notation is correct' do
      context 'when standart start arrangement was passed' do
        it 'should create field with 32 figures on their positions' do
          field = field_factory.create_field FenNotation::START_ARRANGEMENT
          expect(field).to be_a Field
          expect(field.figures.length).to eql 32

          white_left_rook = field.figure_by_position(Position.new(0,0))
          white_left_knight = field.figure_by_position(Position.new(1,0))
          white_left_bishop = field.figure_by_position(Position.new(2,0))
          white_queen = field.figure_by_position(Position.new(3,0))
          white_king = field.figure_by_position(Position.new(4,0))
          white_right_bishop = field.figure_by_position(Position.new(5,0))
          white_right_knight = field.figure_by_position(Position.new(6,0))
          white_right_rook = field.figure_by_position(Position.new(7,0))

          white_pawns = []
          white_pawns << field.figure_by_position(Position.new(0,1))
          white_pawns << field.figure_by_position(Position.new(1,1))
          white_pawns << field.figure_by_position(Position.new(2,1))
          white_pawns << field.figure_by_position(Position.new(3,1))
          white_pawns << field.figure_by_position(Position.new(4,1))
          white_pawns << field.figure_by_position(Position.new(5,1))
          white_pawns << field.figure_by_position(Position.new(6,1))
          white_pawns << field.figure_by_position(Position.new(7,1))

          black_left_rook = field.figure_by_position(Position.new(0,7))
          black_left_knight = field.figure_by_position(Position.new(1,7))
          black_left_bishop = field.figure_by_position(Position.new(2,7))
          black_queen = field.figure_by_position(Position.new(3,7))
          black_king = field.figure_by_position(Position.new(4,7))
          black_right_bishop = field.figure_by_position(Position.new(5,7))
          black_right_knight = field.figure_by_position(Position.new(6,7))
          black_right_rook = field.figure_by_position(Position.new(7,7))

          black_pawns = []
          black_pawns << field.figure_by_position(Position.new(0,6))
          black_pawns << field.figure_by_position(Position.new(1,6))
          black_pawns << field.figure_by_position(Position.new(2,6))
          black_pawns << field.figure_by_position(Position.new(3,6))
          black_pawns << field.figure_by_position(Position.new(4,6))
          black_pawns << field.figure_by_position(Position.new(5,6))
          black_pawns << field.figure_by_position(Position.new(6,6))
          black_pawns << field.figure_by_position(Position.new(7,6))

          expect(white_left_rook).to be_a Rook
          expect(white_left_rook.color.white?).to eql true
          expect(white_left_knight).to be_a Knight
          expect(white_left_knight.color.white?).to eql true
          expect(white_left_bishop).to be_a Bishop
          expect(white_left_bishop.color.white?).to eql true
          expect(white_queen).to be_a Queen
          expect(white_queen.color.white?).to eql true
          expect(white_king).to be_a King
          expect(white_king.color.white?).to eql true
          expect(white_right_bishop).to be_a Bishop
          expect(white_right_bishop.color.white?).to eql true
          expect(white_right_knight).to be_a Knight
          expect(white_right_knight.color.white?).to eql true
          expect(white_right_rook).to be_a Rook
          expect(white_right_rook.color.white?).to eql true
          expect(white_pawns.all? { |pawn| pawn.is_a?(Pawn) && pawn.color.white? }).to eql true

          expect(black_left_rook).to be_a Rook
          expect(black_left_rook.color.white?).to eql false
          expect(black_left_knight).to be_a Knight
          expect(black_left_knight.color.white?).to eql false
          expect(black_left_bishop).to be_a Bishop
          expect(black_left_bishop.color.white?).to eql false
          expect(black_queen).to be_a Queen
          expect(black_queen.color.white?).to eql false
          expect(black_king).to be_a King
          expect(black_king.color.white?).to eql false
          expect(black_right_bishop).to be_a Bishop
          expect(black_right_bishop.color.white?).to eql false
          expect(black_right_knight).to be_a Knight
          expect(black_right_knight.color.white?).to eql false
          expect(black_right_rook).to be_a Rook
          expect(black_right_rook.color.white?).to eql false
          expect(black_pawns.all? { |pawn| pawn.is_a?(Pawn) && !pawn.color.white? }).to eql true
        end
      end
    end

    context 'when fen notation is not correct' do
      it 'should raise ArgumentError exception' do
        expect { field_factory.create_field 'foo/bar' }.to raise_error ArgumentError
      end
    end
  end
end