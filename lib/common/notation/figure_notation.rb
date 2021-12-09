class FigureNotation < Notation
  attr_reader :name

  def initialize(figure)
    @sign = figure_to_sign figure
    @name = figure_to_name figure
  end

  def get_notations
    Configuration::figures_notation
  end

  private

  def figure_to_name(figure)
    notations = get_notations
    figure_name = figure.class.name.downcase
    notations[figure_name] if notations[figure_name]
  end

  def figure_to_sign(figure)
    notations = get_notations
    figure_name = "#{figure.color.name}_#{figure.class.name.downcase}"
    notations[figure_name] if notations[figure_name]
  end
end