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
    end

    def draw
    end

    def surrender
    end

    def set_white_player(player)
    end

    def set_black_player(player)
    end

    def current_notation
      @field.notation
    end

    def moves_history
    end

    def current_player
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
    end

    def undo_move
    end

    def retry_move
    end

    def go_to_move(move_number)
    end

    private

    def create_round
      @round = @round_factory.create_round @turn
    end
  end
end
