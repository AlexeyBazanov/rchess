require 'spec_helper'

describe Color do
  let(:white_color) { Color.new Color::WHITE }
  let(:black_color) { Color.new Color::BLACK }

  describe '#white?' do
    context 'given a white color' do
      it 'should return true' do
        expect(white_color.white?).to be true
      end
    end

    context 'given a black color' do
      it 'should return false' do
        expect(black_color.white?).to be false
      end
    end
  end

  describe '#same?' do
    context 'given a white color' do
      it 'should return true for white color' do
        expect(white_color.same? white_color).to be true
      end

      it 'should return false for black color' do
        expect(white_color.same? black_color).to be false
      end
    end

    context 'given a black color' do
      it 'should return true for black color' do
        expect(black_color.same? black_color).to be true
      end

      it 'should return false for white color' do
        expect(black_color.same? white_color).to be false
      end
    end
  end

  describe '#opposite' do
    context 'given a white color' do
      it 'should return black color' do
        expect(white_color.opposite).to be_a Color
        expect(white_color.opposite.white?).to be false
      end
    end

    context 'given a black color' do
      it 'should return white color' do
        expect(black_color.opposite).to be_a Color
        expect(black_color.opposite.white?).to be true
      end
    end
  end
end