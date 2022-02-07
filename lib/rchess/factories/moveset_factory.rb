module Rchess
  class MovesetFactory
    attr_reader :move_factory

    def initialize(move_factory)
      @move_factory = move_factory
    end

    def create_by_directions(position_from, directions, cells_limit: 7)
      moves = []
      directions.each do |direction|
        direction_moves = create_by_direction position_from, direction, cells_limit: cells_limit
        moves.concat direction_moves
      end
      moves
    end

    def create_by_direction(position_from, direction, cells_limit: 7)
      moves = []
      barrier_figures = []
      position_to = position_from

      cells_limit.times do
        position_to = PositionFactory.create_by_direction position_to, direction

        break unless position_to

        move = @move_factory.create_move position_from,
                                         position_to,
                                         direction: direction,
                                         barrier_figures: barrier_figures.dup,
                                         prev_moves: moves.dup

        break if move.nil?

        barrier_figures.push(move.attacked_figure) if move.has_attacked_figure?

        moves.push move
      end

      moves
    end

    def create_by_offsets(position_from, axis_one_offset:, axis_two_offset:)
      offset_pair_one = [axis_one_offset, -axis_one_offset]
      offset_pair_two = [axis_two_offset, -axis_two_offset]
      offsets = []
      moves = []

      offset_pair_one.each do |first_offset|
        offset_pair_two.each do |second_offset|
          offsets.push({ x: first_offset, y: second_offset })
          offsets.push({ x: second_offset, y: first_offset })
        end
      end

      offsets.each do |offset|
        position_to = PositionFactory::create_by_offset position_from, offset_x: offset[:x], offset_y: offset[:y]
        next unless position_to
        move = @move_factory.create_move position_from, position_to
        moves.push move unless move.nil?
      end

      moves
    end
  end
end