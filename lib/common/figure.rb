class Figure
  attr_reader :name, :color, :moves_count, :position, :notation

  def initialize(name, color)
    @name = name
    @color = color
    @notation = FigureNotation.new self
  end

  def has_moved?
    @moves_count.positive?
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
