require 'spec_helper'
include Rchess

describe Rchess::PawnMoveValidator do
  let(:figure_factory) { FenFigureFactory.new }
  let(:field_factory) { FenFieldFactory.new figure_factory }
  let(:field) { field_factory.create_field fen_notation }
  let(:round_factory) { RoundFactory.new field }
  let(:turn) { Turn.new }
  let(:round) { round_factory.create_round turn }
  let(:pawn_move_validator) { PawnMoveValidator.new field }

  describe '#validate' do
    context 'when turn is white' do
      context 'when invalid moves is exist' do
        let(:fen_notation) { 'rnbqkbnr/pppp2pp/8/8/4p3/5p2/PPPPPPPP/RNBQKBNR' }

        it 'should create move prohibitions' do
          pawn_move_validator.validate turn, round
          prohibitions_num = 0
          pawn = field.figure_by_position PositionFactory.create_by_notation 'e2'
          pawn_move_collection = round.get_move_collection pawn

          if pawn_move_collection
            pawn_move_collection.moves.each { |move| prohibitions_num += 1 if move.has_prohibition? }
          end

          expect(prohibitions_num).to eql 2
        end
      end
    end
  end
end