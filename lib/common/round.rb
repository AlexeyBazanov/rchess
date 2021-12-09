class Round
  attr_reader :white_move_collections, :black_move_collections,
              :white_castlings, :black_castlings

  def initialize(white_move_collections, black_move_collections, white_castlings, black_castlings)
    @white_move_collections = white_move_collections
    @black_move_collections = black_move_collections
    @white_castlings = white_castlings
    @black_castlings = black_castlings
  end

  def get_move_collections(color)
    if color.white? then @white_move_collections else @black_move_collections end
  end
  
  def get_move_collection(figure)
    move_collections = get_move_collections figure.color
    move_collections.find { |collection| collection.figure.same? figure }
  end

  def get_move_collection_by_name(figure_name, figure_color)

  end

  def get_castlings(color)
    if color.white? then @white_castlings else @black_castlings end
  end
end