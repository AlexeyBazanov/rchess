require 'common/field'
require 'common/color'
require 'common/castling/castling'
require 'common/castling/castling_pattern'
require 'common/castling/castling_side'
require 'common/castling/patterns/white_king_side_castling_pattern'
require 'common/castling/patterns/black_king_side_castling_pattern'
require 'common/castling/patterns/white_queen_side_castling_pattern'
require 'common/castling/patterns/black_queen_side_castling_pattern'
require 'factories/castling/castling_side_factory'
require 'factories/castling/castling_factory'
require 'factories/color_factory'

describe CastlingFactory do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:castling_factory) { CastlingFactory.new(*field) }

  describe '.create_king_side_castling' do
    context 'when king and rook on their start positions' do
      let(:field) { field_factory.create_field 'rnbqkbnr/pppppppp/8/8/6P1/2N2N1B/PPPPPP1P/R1BQK2R' }

      context 'when white king color was passed' do
        subject { castling_factory.create_king_side_castling ColorFactory.create_white }

        it 'should return castling' do
          expect(subject).to be_a Castling
        end

        it 'should content correct king move' do
          expect(subject.king_move.position_to.notation.to_s).to eql 'g1'
        end

        it 'should content correct rook move' do
          expect(subject.rook_move.position_to.notation.to_s).to eql 'f1'
        end
      end

      context 'when black king color was passed' do
        subject { castling_factory.create_king_side_castling ColorFactory.create_black }

        it 'should return castling' do
          expect(subject).to be_a Castling
        end

        it 'should content correct king move' do
          expect(subject.king_move.position_to.notation.to_s).to eql 'g8'
        end

        it 'should content correct rook move' do
          expect(subject.rook_move.position_to.notation.to_s).to eql 'f8'
        end
      end
    end

    context 'when king is not in it`s start position' do
      let(:field) { field_factory.create_field 'rnbq1bnr/ppppkppp/8/4p3/4P3/8/PPPPKPPP/RNBQ1BNR' }

      context 'when white king color was passed' do
        subject { castling_factory.create_king_side_castling ColorFactory.create_white }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end

      context 'when black king color was passed' do
        subject { castling_factory.create_king_side_castling ColorFactory.create_black }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end
    end

    context 'when rook is not in it`s start position' do
      let(:field) { field_factory.create_field 'rnbqkbn1/ppppppp1/7r/7p/7P/7R/PPPPPPP1/RNBQKBN1' }

      context 'when white king color was passed' do
        subject { castling_factory.create_king_side_castling ColorFactory.create_white }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end

      context 'when black king color was passed' do
        subject { castling_factory.create_king_side_castling ColorFactory.create_white }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end
    end
  end

  describe '.create_queen_side_castling' do
    context 'when king and rook are on their start positions' do
      let(:field) { field_factory.create_field 'rnbqkbnr/pppppppp/8/8/3P1B2/2N5/PPPQPPPP/R3KBNR' }

      context 'when white king color was passed' do
        subject { castling_factory.create_queen_side_castling ColorFactory.create_white }

        it 'should return castling' do
          expect(subject).to be_a Castling
        end

        it 'should content correct king move' do
          expect(subject.king_move.position_to.notation.to_s).to eql 'c1'
        end

        it 'should content correct rook move' do
          expect(subject.rook_move.position_to.notation.to_s).to eql 'd1'
        end
      end

      context 'when black king color was passed' do
        subject { castling_factory.create_queen_side_castling ColorFactory.create_black }

        it 'should return castling' do
          expect(subject).to be_a Castling
        end

        it 'should content correct king move' do
          expect(subject.king_move.position_to.notation.to_s).to eql 'c8'
        end

        it 'should content correct rook move' do
          expect(subject.rook_move.position_to.notation.to_s).to eql 'd8'
        end
      end
    end

    context 'when king is not in it`s start position' do
      let(:field) { field_factory.create_field 'rnbq1bnr/ppppkppp/8/4p3/3P1B2/2N1P3/PPPQKPPP/R4BNR' }

      context 'when white king color was passed' do
        subject { castling_factory.create_queen_side_castling ColorFactory.create_white }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end

      context 'when black king color was passed' do
        subject { castling_factory.create_queen_side_castling ColorFactory.create_black }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end
    end

    context 'when rook is not in it`s start position' do
      let(:field) { field_factory.create_field '1nbqkbnr/1ppppppp/r7/p7/P7/R7/1PPPPPPP/1NBQKBNR' }

      context 'when white king color was passed' do
        subject { castling_factory.create_queen_side_castling ColorFactory.create_white }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end

      context 'when black king color was passed' do
        subject { castling_factory.create_queen_side_castling ColorFactory.create_black }

        it 'should return nil' do
          expect(subject).to be_nil
        end
      end
    end
  end

  describe '.create_castlings' do
    let(:field) { field_factory.create_field 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR' }

    context 'when white king color was passed' do
      subject { castling_factory.create_castlings ColorFactory.create_white }

      it 'should return two castling' do
        expect(subject).to be_a Array
        expect(subject.length).to eql 2
        expect(subject.all? { |item| item.is_a? Castling }).to be_truthy
      end
    end

    context 'when black king color was passed' do
      subject { castling_factory.create_castlings ColorFactory.create_black }

      it 'should return two castling' do
        expect(subject).to be_a Array
        expect(subject.length).to eql 2
        expect(subject.all? { |item| item.is_a? Castling }).to be_truthy
      end
    end
  end
end