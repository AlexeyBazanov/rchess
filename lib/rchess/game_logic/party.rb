module Rchess
  class Party
    attr_reader :timer, :history

    def initialize(field, turn, round_factory)
      @field = field
      @turn = turn
      @round_factory = round_factory
      @timer = Timer.new @turn
      @history = History.new
      @figure_factory = FenFigureFactory.new
      @last_transform_move = nil
    end

    def start
      create_round
      @timer.start
    end

    def stop
      @timer.stop
    end

    def draw
      stop
    end

    def surrender
      stop
    end

    def current_notation
      @field.notation.to_s
    end

    def moves_history
      @history.movables
    end

    def taken_figures_history
      @history.white_taken_figures_history + @history.black_taken_figures_history
    end

    def white_taken_figures_history
      @history.white_taken_figures_history
    end

    def black_taken_figures_history
      @history.black_taken_figures_history
    end

    def current_player_color
      @turn.color.name
    end

    def current_turn_number
      @turn.number
    end

    def white_move?
      @turn.color.white?
    end

    def awaiting_transform?
      @last_transform_move.is_a?(Move)
    end

    def do_move(notation_from, notation_to)
      return false if awaiting_transform?

      position_from = PositionFactory.create_by_notation notation_from
      position_to = PositionFactory.create_by_notation notation_to
      movable = MoveService.do_move @field, @turn, @round, position_from, position_to

      return false unless movable

      if need_transform_for? movable
        @last_transform_move = movable
        return true
      end

      @history.add_movable movable
      @turn.next
      create_round
      true
    end

    def undo_move
      return false if awaiting_transform?

      movable = @history.prev
      return false unless movable

      MoveService.undo_move @field, movable
      @turn.prev
      create_round
      true
    end

    def redo_move
      return false if awaiting_transform?

      movable = @history.next
      return false unless movable

      MoveService.redo_move @field, movable
      @turn.next
      create_round
      true
    end

    def transform(figure_notation)
      return false unless awaiting_transform?

      figure = @figure_factory.create_figure figure_notation
      transform = MoveService.do_transform @field, @last_transform_move, figure
      return false unless transform

      @history.add_movable @last_transform_move
      @turn.next
      create_round
      @last_transform_move = nil
      true
    end

    private

    def create_round
      @round = @round_factory.create_round @turn
    end

    def need_transform_for?(movable)
      movable.is_a?(Move) && movable.transform_possible?
    end
  end
end
