class Figure
  attr_reader :name, :color, :notation, :moves_count, :position

  def initialize(name, color)
    @name = name
    @color = color
    @notation = FigureNotation.new self
    @moves_count = 0
  end

  def position=(position)
    @position = position if position.is_a? Position
  end

  def has_moved?
    @moves_count.positive?
  end

  def increase_moves
    @moves_count += 1
  end

  def reduce_moves
    @moves_count -= 1 if has_moved?
  end

  def similar?(figure)
    @name == figure.name
  end

  def same?(figure)
    similar? figure and @position.same? figure.position
  end

  def under_attack?(attack_position)
    @position.same? attack_position
  end
end
