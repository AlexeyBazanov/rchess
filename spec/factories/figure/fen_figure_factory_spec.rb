require 'spec_helper'

describe FenFigureFactory do
  let(:factory) { FenFigureFactory.new }

  shared_examples 'figure' do |fen_notation, return_class, return_color|
    let(:figure) { factory.create_figure fen_notation }

    it "should be a #{return_class.class} instance" do
      expect(figure).to be_a return_class
    end

    it "should be a #{return_color.name} color" do
      expect(figure.color.same? return_color).to be true
    end
  end

  describe '#create_figure' do
    context 'when correct FEN notation was passed' do
      context 'when white king notation was passed' do
        it_behaves_like 'figure', FenNotation::WHITE_KING, King, ColorFactory.create_white
      end

      context 'when black king notation was passed' do
        it_behaves_like 'figure', FenNotation::BLACK_KING, King, ColorFactory.create_black
      end

      context 'when white queen notation was passed' do
        it_behaves_like 'figure', FenNotation::WHITE_QUEEN, Queen, ColorFactory.create_white
      end

      context 'when black queen notation was passed' do
        it_behaves_like 'figure', FenNotation::BLACK_QUEEN, Queen, ColorFactory.create_black
      end

      context 'when white bishop notation was passed' do
        it_behaves_like 'figure', FenNotation::WHITE_BISHOP, Bishop, ColorFactory.create_white
      end

      context 'when black bishop notation was passed' do
        it_behaves_like 'figure', FenNotation::BLACK_BISHOP, Bishop, ColorFactory.create_black
      end

      context 'when white knight notation was passed' do
        it_behaves_like 'figure', FenNotation::WHITE_KNIGHT, Knight, ColorFactory.create_white
      end

      context 'when black knight notation was passed' do
        it_behaves_like 'figure', FenNotation::BLACK_KNIGHT, Knight, ColorFactory.create_black
      end

      context 'when white rook notation was passed' do
        it_behaves_like 'figure', FenNotation::WHITE_ROOK, Rook, ColorFactory.create_white
      end

      context 'when black rook notation was passed' do
        it_behaves_like 'figure', FenNotation::BLACK_ROOK, Rook, ColorFactory.create_black
      end

      context 'when white pawn notation was passed' do
        it_behaves_like 'figure', FenNotation::WHITE_PAWN, Pawn, ColorFactory.create_white
      end

      context 'when black pawn notation was passed' do
        it_behaves_like 'figure', FenNotation::BLACK_PAWN, Pawn, ColorFactory.create_black
      end
    end
  end
end