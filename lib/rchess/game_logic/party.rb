module Rchess
  class Party
    attr_reader :timer, :move_log

    def initialize(field, turn, round_factory)
      @field = field
      @turn = turn
      @round_factory = round_factory
      @timer = Timer.new @turn
      @move_log = MoveLog.new
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
      @field.notation
    end

    def moves_history
      @move_log.moves_history
    end

    def taken_figures_history
      @move_log.white_taken_figures_history + @move_log.black_taken_figures_history
    end

    def white_taken_figures_history
      @move_log.white_taken_figures_history
    end

    def black_taken_figures_history
      @move_log.black_taken_figures_history
    end

    def current_player_color
      @turn.color.name
    end

    def current_turn_number
      @turn.number
    end

    def do_move(notation_from, notation_to)
      return false if @round.nil?

      position_from = PositionFactory.create_by_notation notation_from
      position_to = PositionFactory.create_by_notation notation_to

      return false unless @field.figure_present? position_from

      figure = @field.figure_by_position position_from

      return false unless figure.color.same? @turn.color

      move_collection = @round.get_move_collection figure

      return false unless move_collection
      return false unless move_collection.can_move_to? position_to

      @field.move_figure position_from, position_to
      @move_log.add_move move_collection.find_move position_from, position_to
      @turn.next
      create_round
      true
    end

    def undo_move
      move = @move_log.prev_move
      return false unless move

      @field.move_figure move.position_to, move.position_from, is_increases: false
      @field.set_figure move.attacked_figure, move.attacked_figure.position if move.has_attacked_figure?
      @turn.prev
      create_round
      true
    end

    def redo_move
      move = @move_log.next_move
      return false unless move

      @field.move_figure move.position_from, move.position_to
      @turn.next
      create_round
      true
    end

    private

    def create_round
      @round = @round_factory.create_round @turn
    end
  end
end
