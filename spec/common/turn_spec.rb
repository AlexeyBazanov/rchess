# require 'common/turn'
require 'spec_helper'

describe Turn do
  let(:turn) { Turn.new }

  describe '#next' do
    it 'should increase number by one' do
      expect(turn.number).to eql 1
      turn.next
      expect(turn.number).to eql 2
    end
  end

  describe '#prev' do
    context 'when number greater than 1' do
      it 'should decrease number by one' do
        turn.next
        turn.next
        turn.prev
        expect(turn.number).to eql 2
      end
    end

    context 'when number less or equal 1' do
      it 'should doesnt decrease number' do
        turn.prev
        turn.prev
        expect(turn.number).to eql 1
      end
    end
  end

  describe '#color' do
    context 'when turn number is odd' do
      it 'should return white color' do
        expect(turn.color.white?).to eql true
      end
    end

    context 'when turn number is even' do
      it 'should return black color' do
        turn.next
        expect(turn.color.white?).to eql false
      end
    end
  end
end