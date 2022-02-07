class CellRenderer
  attr_reader :figure_renderer

  def initialize
    @figure_renderer = FigureRenderer.new
  end

  def render(cell)
    raise "Parameter `cell` must be an object of Cell class!" unless cell.is_a? Cell
    "[ #{render_cell cell} ]"
  end

  private

  def render_cell(cell)
    if cell.has_figure? then render_figure(cell) else render_empty end
  end

  def render_figure(cell)
    @figure_renderer.render(cell.figure)
  end

  def render_empty
    ' '
  end
end