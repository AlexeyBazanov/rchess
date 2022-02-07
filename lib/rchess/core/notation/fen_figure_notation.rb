module Rchess
  class FenFigureNotation < AbstractNotation
    attr_reader :name

    def initialize(figure)
      @sign = get_figure_sign figure
      @name = get_figure_name figure
    end

    def get_figure_name(figure)
      figure.class.name
    end

    def get_figure_sign(figure)
      sign = figure.class.name[0]
      figure.color.white? ? sign.upcase : sign.downcase
    end
  end
end
