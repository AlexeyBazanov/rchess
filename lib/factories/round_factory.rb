class RoundFactory
  attr_reader :field, :move_collections_factory, :castling_factory, :round_validator
  attr_accessor :skip_validation

  def initialize(field)
    @field = field
    @move_collections_factory = MoveCollectionsFactory.new field
    @castling_factory = CastlingFactory.new field
    @skip_validation = skip_validation
  end

  def create_round(turn)
    white_castlings, black_castlings = create_castlings turn
    white_move_collections, black_move_collections = create_move_collections
    Round.new white_move_collections, black_move_collections, white_castlings, black_castlings
  end

  private

  def create_castlings(turn)
    white_castlings = @castling_factory.create_castlings turn.color
    black_castlings = @castling_factory.create_castlings turn.color
    [white_castlings, black_castlings]
  end

  def create_move_collections
    white_move_collections = @move_collections_factory.create_move_collections ColorFactory.create_white
    black_move_collections = @move_collections_factory.create_move_collections ColorFactory.create_black
    [white_move_collections, black_move_collections]
  end
end