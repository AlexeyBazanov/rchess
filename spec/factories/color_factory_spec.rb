require 'spec_helper'

shared_examples 'Color instance' do
  it 'should be a Color class instance' do
    expect(subject).to be_a Color
  end
end

shared_examples 'white color' do
  it_behaves_like 'Color instance'

  it 'should has name parameter equal `white`' do
    expect(subject.same?(white_color)).to be true
  end
end

shared_examples 'black color' do
  it_behaves_like 'Color instance'

  it 'should has name parameter equal `black`' do
    expect(subject.same?(black_color)).to be true
  end
end

describe ColorFactory do

  let(:white_color) { Color.new Color::WHITE }
  let(:black_color) { Color.new Color::BLACK }

  describe '.create_white' do
    subject { ColorFactory.create_white }

    it_behaves_like 'white color'
  end

  describe '.create_black' do
    subject { ColorFactory.create_black }

    it_behaves_like 'black color'
  end

  describe '.opposite' do
    context 'when not color as argument was passed' do
      it 'should raise ArgumentError exception' do
        expect { ColorFactory.create_opposite 'foo' }.to raise_error ArgumentError
      end
    end

    context 'when white color parameter was passed' do
      subject { ColorFactory.create_opposite white_color }

      it_behaves_like 'black color'
    end

    context 'when black color parameter was passed' do
      subject { ColorFactory.create_opposite black_color }

      it_behaves_like 'white color'
    end
  end
end