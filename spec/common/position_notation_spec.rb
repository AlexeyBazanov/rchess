require 'spec_helper'

describe PositionNotation do
  let(:start_coordinate) { Position::START }
  let(:finish_coordinate) { Position::FINISH }

  let(:left_down_corner_position) { Position.new start_coordinate, start_coordinate }
  let(:right_up_corner_position) { Position.new finish_coordinate, finish_coordinate }

  let(:left_down_corner_position_notation) { PositionNotation.new left_down_corner_position }
  let(:right_up_corner_position_notation) { PositionNotation.new right_up_corner_position }

  describe '#initialize' do
    it 'should can be able to convert to a string' do
      expect(left_down_corner_position_notation.to_s).to be_a String
      expect(right_up_corner_position_notation.to_s).to be_a String
    end

    it 'should be a correct chess position notation' do
      expect(left_down_corner_position_notation.to_s).to eql 'a1'
      expect(right_up_corner_position_notation.to_s).to eql 'h8'
    end
  end
end