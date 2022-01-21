class FigureNotation < AbstractNotation
  attr_reader :name

  def initialize(figure)
    @notations = Configuration::figures_notation
    @sign = figure_to_sign figure
    @name = figure_to_name figure
  end

  private

  def figure_to_name(figure)
    figure_name = figure.class.name.downcase
    @notations[figure_name] if @notations[figure_name]
  end

  def figure_to_sign(figure)
    figure_name = "#{figure.color.name}_#{figure.class.name.downcase}"
    @notations[figure_name] if @notations[figure_name]
  end
end