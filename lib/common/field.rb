class Field
  attr_reader :cells

  def initialize
    create_cells
  end

  def cell_by_position(position)
    @cells[position.x][position.y]
  end

  def cell_by_coordinates(x, y)
    @cells[x][y]
  end

  def figures(color=nil, class_type=nil)
    figures = []
    @cells.each do |row|
      row.each do |cell|
        next unless cell.has_figure?

        is_same_color = color.is_a?(Color) ? cell.figure.color.same?(color) : true
        is_same_class = !class_type.nil? ? cell.figure.is_a?(class_type) : true

        figures.push(cell.figure) if is_same_color && is_same_class
      end
    end
    figures
  end

  def figure_by_position(position)
    cell = cell_by_position position
    cell.figure if cell.has_figure?
  end

  def figure_by_type(class_type, color)
    figures = figures(color)
    figures.each do |figure|
      return figure if figure.is_a? class_type
    end
    nil
  end

  def figure_present?(position)
    cell = cell_by_position position
    cell.has_figure?
  end

  def set_figure(figure, position)
    cell_by_position(position).figure = figure
    figure.position = position
  end

  def move_figure(position_from, position_to)
    cell_from = cell_by_position position_from
    return unless cell_from.has_figure?

    set_figure cell_from.figure, position_to
    cell_from.figure.increase_moves
    cell_from.clear_figure
  end

  def remove_figure(position)
    cell_by_position(position).clear_figure
  end

  private

  def create_cells
    @cells = []
    row = []

    Position::LIST.each do |x|
      Position::LIST.each do |y|
        position = PositionFactory.create_by_coordinates x, y
        cell = Cell.new position
        row.push cell
      end
      cells.push row
      row = []
    end
  end
end
