require 'common/position'
require 'common/notation/fen_notation'
require 'factories/position_factory'
require 'common/move/move_direction'

describe PositionFactory do
  describe '.create_by_coordinates' do
    context 'when correct coordinates were passed' do
      it 'should create Position instance' do
        expect(PositionFactory.create_by_coordinates(1, 2)).to be_a Position
      end
    end

    context 'when incorrect x coordinate were passed' do
      it 'should raise ArgumentError exception' do
        expect { PositionFactory.create_by_coordinates(8, 1) }.to raise_error ArgumentError
        expect { PositionFactory.create_by_coordinates(-1, 1) }.to raise_error ArgumentError
        expect { PositionFactory.create_by_coordinates('foo', 1) }.to raise_error ArgumentError
      end
    end

    context 'when incorrect y coordinate were passed' do
      it 'should raise ArgumentError exception' do
        expect { PositionFactory.create_by_coordinates(1, -1) }.to raise_error ArgumentError
        expect { PositionFactory.create_by_coordinates(1, 8) }.to raise_error ArgumentError
        expect { PositionFactory.create_by_coordinates(1, 'foo') }.to raise_error ArgumentError
      end
    end
  end

  describe '.create_by_notation' do
    context 'when correct notation string were passed' do
      it 'should create Position instance' do
        expect(PositionFactory.create_by_notation('e4')).to be_a Position
      end
    end

    context 'when invalid notation string were passed' do
      it 'should raise ArgumentError exception' do
        expect { PositionFactory.create_by_notation(43) }.to raise_error ArgumentError
        expect { PositionFactory.create_by_notation('e9') }.to raise_error ArgumentError
        expect { PositionFactory.create_by_notation('z4') }.to raise_error ArgumentError
        expect { PositionFactory.create_by_notation('abc') }.to raise_error ArgumentError
      end
    end
  end

  describe '.create_by_offset' do
    context 'when correct arguments were passed' do
      subject { PositionFactory.create_by_offset(Position.new(1, 1), offset_x: 1, offset_y: 1) }

      it 'should create Position instance' do
        expect(subject).to be_a Position
      end

      it 'should have correct x coordinate offset' do
        expect(subject.x).to eql(2)
      end

      it 'should have correct y coordinate offset' do
        expect(subject.x).to eql(2)
      end
    end

    context 'when incorrect position argument was passed' do
      it 'should raise ArgumentError exception' do
        expect { PositionFactory.create_by_offset('foo', offset_x: 1, offset_y: 1) }.to raise_error ArgumentError
      end
    end

    context 'when incorrect offsets arguments were passed' do
      it 'should raise ArgumentError exception' do
        expect { PositionFactory.create_by_offset(Position.new(1, 1), offset_x: 'foo', offset_y: 1) }.to raise_error ArgumentError
        expect { PositionFactory.create_by_offset(Position.new(1, 1), offset_x: 1, offset_y: 'bar') }.to raise_error ArgumentError
      end
    end
  end

  describe '.create_by_direction' do
    context 'when correct arguments were passed' do
      subject { PositionFactory.create_by_direction Position.new(5,5), MoveDirection.new(*direction) }

      context 'in any case' do
        let(:direction) { MoveDirection::STRAIGHT[:up] }
        it 'should create Position class instance' do
          expect(subject).to be_a Position
        end
      end

      context 'when direction is UP' do
        let(:direction) { MoveDirection::STRAIGHT[:up] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.y).to eql(6)
        end
      end

      context 'when direction is DOWN' do
        let(:direction) { MoveDirection::STRAIGHT[:down] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.y).to eql(4)
        end
      end

      context 'when direction is LEFT' do
        let(:direction) { MoveDirection::STRAIGHT[:left] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.x).to eql(4)
        end
      end

      context 'when direction is RIGHT' do
        let(:direction) { MoveDirection::STRAIGHT[:right] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.x).to eql(6)
        end
      end

      context 'when direction is TOP LEFT' do
        let(:direction) { MoveDirection::DIAGONAL[:top_left] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.x).to eql(4)
          expect(subject.y).to eql(6)
        end
      end

      context 'when direction is TOP RIGHT' do
        let(:direction) { MoveDirection::DIAGONAL[:top_right] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.x).to eql(6)
          expect(subject.y).to eql(6)
        end
      end

      context 'when direction is DOWN LEFT' do
        let(:direction) { MoveDirection::DIAGONAL[:down_left] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.x).to eql(4)
          expect(subject.y).to eql(4)
        end
      end

      context 'when direction is DOWN RIGHT' do
        let(:direction) { MoveDirection::DIAGONAL[:down_right] }
        it 'should create the correct offset for the coordinates' do
          expect(subject.x).to eql(6)
          expect(subject.y).to eql(4)
        end
      end
    end

    context 'when invalid position argument was passed' do
      it 'should raise ArgumentError' do
        expect {
          PositionFactory.create_by_direction 'foo', MoveDirection.new(MoveDirection::STRAIGHT[:up])
        }.to raise_error ArgumentError
      end
    end

    context 'when invalid direction argument was passed' do
      it 'should raise ArgumentError' do
        expect { PositionFactory.create_by_direction Position.new(1, 1), 'bar' }.to raise_error ArgumentError
      end
    end
  end
end