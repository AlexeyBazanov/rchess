require 'common/notation/position_notation'
require 'common/position'

describe Position do
  let(:position_one) { Position.new(Position::START, Position::START) }
  let(:position_two) { Position.new(Position::FINISH, Position::FINISH) }

  describe '#initialize' do
    context 'when valid coordinates were passed' do
      it 'should have notation' do
        expect(position_one.notation).to be_a PositionNotation
      end
    end
  end

  describe '#same?' do
    context 'when compare with same position' do
      it 'should return true' do
        expect(position_one.same? position_one).to be true
      end
    end

    context 'when compare with another position' do
      it 'should return false' do
        expect(position_one.same? position_two).to be false
      end
    end
  end

  describe '#same_x?' do
    context 'when compare with position with same x coordinate' do
      it 'should return true' do
        expect(position_one.same_x? position_one).to be true
      end
    end

    context 'when compare with position with different x coordinate' do
      it 'should return false' do
        expect(position_one.same_x? position_two).to be false
      end
    end
  end

  describe '#same_y?' do
    context 'when compare with position with same y coordinate' do
      it 'should return true' do
        expect(position_one.same_y? position_one).to be true
      end
    end

    context 'when compare with position with different y coordinate' do
      it 'should return false' do
        expect(position_one.same_y? position_two).to be false
      end
    end
  end

  describe '#nearby_x?' do
    context 'when compare with position where x coordinate differs by one' do
      subject { Position.new position_one.x + 1, position_one.y }
      it 'should return true' do
        expect(subject.nearby_x? position_one).to be true
      end
    end

    context 'when compare with position where x coordinate differs not by one' do
      subject { Position.new position_one.x + 2, position_one.y }
      it 'should return false' do
        expect(subject.nearby_x? position_one).to be false
      end
    end
  end

  describe '#nearby_y?' do
    context 'when compare with position where y coordinate differs by one' do
      subject { Position.new position_one.x, position_one.y + 1 }
      it 'should return true' do
        expect(subject.nearby_y? position_one).to be true
      end
    end

    context 'when compare with position where y coordinate differs not by one' do
      subject { Position.new position_one.x, position_one.y + 2 }
      it 'should return false' do
        expect(subject.nearby_y? position_one).to be false
      end
    end
  end
end