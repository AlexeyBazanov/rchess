# require 'config/configuration'
# require 'common/notation/abstract_notation'
# require 'common/notation/figure_notation'
require 'common/figure'

describe Figure do
  let(:white_king) { Figure.new(FenNotation::WHITE_KING, Color.new(Color::WHITE)) }
  let(:black_king) { Figure.new(FenNotation::BLACK_KING, Color.new(Color::BLACK)) }
  let(:white_rook) { Figure.new(FenNotation::WHITE_ROOK, Color.new(Color::BLACK)) }

  describe '#similar?' do
    context 'when figures name is similar' do
      it 'should return true' do
        expect(white_king.similar? black_king).to be true
      end
    end

    context 'when figures name is different' do
      it 'should return false' do
        expect(white_king.similar? white_rook).to be false
      end
    end
  end

  describe '#same?' do
    context 'when figures name and position same' do
      it 'should return true' do
        white_king.position = Position.new(0, 4)
        expect(white_king.same? white_king).to be true
      end
    end

    context 'when figures name or position does not same' do
      it 'should return false' do
        white_king.position = Position.new(0, 4)
        black_king.position = Position.new(7, 4)
        expect(white_king.same? black_king).to be false
      end
    end
  end

  describe '#under_attack?' do
    context 'when attack position and figure position same' do
      it 'should return true' do
        position = Position.new(0, 4)
        white_king.position = position
        expect(white_king.under_attack? position).to be true
      end
    end

    context 'when attack position and figure position does not same' do
      it 'should return false' do
        attack_position = Position.new(5, 5)
        white_king.position = Position.new(0, 4)
        expect(white_king.under_attack? attack_position).to be false
      end
    end
  end
end