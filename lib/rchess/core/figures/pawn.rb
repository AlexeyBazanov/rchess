module Rchess
  class Pawn < Figure
    attr_accessor :can_be_taking_on_pass, :transform_possible

    def initialize(name, color)
      super name, color
      @can_be_taking_on_pass = false
      @transform_possible = false
    end
  end
end