module Rchess
  class AbstractFigureFactory
    def create_figure(name)
      raise 'This method abstract!'
    end
  end
end