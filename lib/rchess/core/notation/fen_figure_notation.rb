module Rchess
  class FenFigureNotation < AbstractNotation
    attr_reader :name

    def initialize(figure)
      @sign = get_figure_sign figure
      @name = get_figure_name figure
    end

    def get_figure_name(figure)
      figure.name
    end

    def get_figure_sign(figure)
      figure.color.white? ? figure.name[0].upcase : figure.name[0].downcase
    end
  end
end
