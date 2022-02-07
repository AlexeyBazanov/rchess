module Rchess
  class Round
    attr_reader :white_move_collections, :black_move_collections,
                :white_castlings, :black_castlings

    def initialize(white_move_collections, black_move_collections, white_castlings, black_castlings)
      @white_move_collections = white_move_collections
      @black_move_collections = black_move_collections
      @white_castlings = white_castlings
      @black_castlings = black_castlings
    end

    def get_move_collections(color, figure_type=nil)
      move_collection = color.white? ? @white_move_collections : @black_move_collections
      move_collection = move_collection.filter { |mc| mc.figure.is_a? figure_type } unless figure_type.nil?
      move_collection
    end

    def get_move_collection(figure)
      return if figure.nil?
      move_collections = get_move_collections figure.color
      move_collections.find { |collection| collection.figure.same? figure }
    end

    def get_castlings(color)
      if color.white? then @white_castlings else @black_castlings end
    end
  end
end
