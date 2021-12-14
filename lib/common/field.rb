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

  def figures(color)
    figures = []
    @cells.each do |row|
      row.each do |cell|
        figure_present = cell.has_figure? and cell.figure.color.same? color
        figures.push(cell.figure) if figure_present
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
  end

  def figure_present?(position)
    cell = cell_by_position position
    cell.has_figure?
  end

  def set_figure(figure, position)
    cell_by_position(position).figure = figure
  end

  def move_figure(position_from, position_to)
    cell_from = cell_by_position position_from
    return unless cell_from.has_figure?

    set_figure cell_from.figure, position_to
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
