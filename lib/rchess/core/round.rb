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

    def get_castling(king, position_to)
      castlings = get_castlings king.color
      castlings.find { |castling| castling.possible? && castling.king_move_position.same?(position_to) }
    end

    def get_movable(figure, position_to)
      if figure.is_a? King
        castling = get_castling figure, position_to
        return castling if castling
      end

      move_collection = get_move_collection figure

      return unless move_collection

      move_collection.find_move figure.position, position_to
    end
  end
end
