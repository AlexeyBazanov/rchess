module Rchess
  class AbstractFieldFactory
    attr_reader :figure_factory

    def initialize(figure_factory)
      @figure_factory = figure_factory
    end

    def create_field
      raise 'This method is abstract!'
    end
  end
end