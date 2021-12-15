class RoundFactory
  attr_reader :field, :move_collections_factory, :castling_factory, :round_validator

  def initialize(field)
    @field = field
    @move_collections_factory = MoveCollectionsFactory.new field
    @castling_factory = CastlingFactory.new field
    @round_validator = RoundValidator.new field
  end

  def create_round(turn)
    white_castlings, black_castlings = create_castlings turn
    white_move_collections, black_move_collections = create_move_collections
    round = Round.new white_move_collections, black_move_collections, white_castlings, black_castlings
    @round_validator.validate turn, round
    round
  end

  private

  def create_castlings(turn)
    white_castlings = []
    black_castlings = []

    if turn.color.white?
      white_castlings = @castling_factory.create_castlings turn.color
    else
      black_castlings = @castling_factory.create_castlings turn.color
    end

    [white_castlings, black_castlings]
  end

  def create_move_collections
    white_move_collections = @move_collections_factory.create_move_collections ColorFactory.create_white
    black_move_collections = @move_collections_factory.create_move_collections ColorFactory.create_black
    [white_move_collections, black_move_collections]
  end
end