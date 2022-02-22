module Rchess
  class MoveService
    class << self
      def do_move(field, turn, round, position_from, position_to)
        unless field.is_a?(Field) && turn.is_a?(Turn) && round.is_a?(Round) &&
          position_from.is_a?(Position) && position_from.is_a?(Position)
          return false
        end

        figure = field.figure_by_position position_from

        return false unless figure
        return false unless figure.color.same? turn.color

        movable = round.get_movable figure, position_to

        return false unless movable

        movable.do field
        movable
      end

      def undo_move(field, movable)
        movable.undo field
      end

      def redo_move(field, movable)
        movable.do field
      end

      def do_transform(field, move, transform_figure)
        move.transform field, transform_figure
      end
    end
  end
end