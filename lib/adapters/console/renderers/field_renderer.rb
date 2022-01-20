class FieldRenderer

  attr_reader :cell_renderer

  def initialize
    @cell_renderer = CellRenderer.new
  end

  def render(field)
    raise "Parameter `field` must be an object of Field class!" unless field.is_a? Field
    output = render_letters
    output += render_cells field
    output += render_letters
    output
  end

  private

  def render_cells(field)
    output = ''
    Position::RANGE.reverse.each do |y|
      output += render_coordinate y
      Position::RANGE.each do |x|
        output += @cell_renderer.render field.cell_by_coordinates x, y
      end
      output += render_coordinate y
      output += "\n"
    end
    output
  end

  def render_letters
    "       A    B    C    D    E    F    G    H  \n"
  end

  def render_coordinate(coordinate, is_letter=false)
    sign = is_letter ? PositionNotation::LETTERS[coordinate] : coordinate + 1
    "  #{sign}  "
  end
end