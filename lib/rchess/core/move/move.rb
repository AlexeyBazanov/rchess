module Rchess
  class Move
    attr_reader :figure, :position_from, :position_to, :direction
    attr_accessor :attacked_figure, :prev_moves, :barrier_figures,
                  :prohibition, :can_be_taking_on_pass, :transform_possible, :score

    def initialize(figure, position_from, position_to, direction=nil, attacked_figure=nil)
      @figure = figure
      @position_from = position_from
      @position_to = position_to
      @direction = direction
      @attacked_figure = attacked_figure
      @can_be_taking_on_pass = false
      @transform_possible = false
      @transform_figure = nil
      @score = 0
      @prev_moves = []
      @barrier_figures = []
    end

    def notation
      MoveNotation.new self
    end

    def move_set
      moves = [self]
      moves.concat @prev_moves if has_prev_moves?
      moves
    end

    def has_prev_moves?
      @prev_moves.length > 0
    end

    def has_barrier_figures?
      @barrier_figures.length > 0
    end

    def blocked_by?(figure)
      @barrier_figures.any? { |barrier_figure| barrier_figure.same? figure }
    end

    def one_opposite_figure_barrier?
      @barrier_figures.length == 1 and @barrier_figures[0].color.same? @figure.color.opposite
    end

    def has_prohibition?
      @prohibition.is_a? MoveProhibition
    end

    def has_attacked_figure?
      @attacked_figure.is_a? Figure
    end

    def attacked_figure_opposite?
      has_attacked_figure? and not @attacked_figure.color.same? @figure.color
    end

    def can_attack?
      attacked_figure_opposite? and not has_barrier_figures? and not has_prohibition?
    end

    def attack_to?(figure)
      return false unless has_attacked_figure?
      figure.same? @attacked_figure
    end

    def possible?
      if has_attacked_figure?
        can_attack?
      else
        not has_barrier_figures? and not has_prohibition?
      end
    end

    def check?
      can_attack? and @attacked_figure.is_a? King
    end

    def covered_check?
      has_attacked_figure? and @attacked_figure.is_a? King and one_opposite_figure_barrier?
    end

    def intersect?(position)
      move_set.each do |move|
        return true if move.position_to.same? position
      end
      false
    end

    def transform_possible?
      @transform_possible
    end

    def transform_possible!
      @transform_possible = true
    end

    def can_be_taking_on_pass?
      @can_be_taking_on_pass
    end

    def can_be_taking_on_pass!
      @can_be_taking_on_pass = true
    end

    def prohibit!(prohibition)
      @prohibition = prohibition
    end

    def do(field)
      field.move_figure @position_from, @position_to
    end

    def undo(field)
      field.move_figure @position_to, @position_from, is_increases: false
      field.set_figure(@attacked_figure, @attacked_figure.position) if has_attacked_figure?
      @transform_figure = nil if @transform_figure
    end

    def transform(field, transform_figure)
      return false unless transform_possible?
      return false unless @transform_figure.is_a? Figure
      @transform_figure = transform_figure
      field.set_figure @transform_figure, @position_to
      true
    end
  end
end
