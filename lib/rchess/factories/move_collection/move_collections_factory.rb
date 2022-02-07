module Rchess
  class MoveCollectionsFactory
    attr_reader :field
    attr_reader :pawn_move_collection_factory
    attr_reader :king_move_collection_factory
    attr_reader :queen_move_collection_factory
    attr_reader :bishop_move_collection_factory
    attr_reader :knight_move_collection_factory
    attr_reader :rook_move_collection_factory

    def initialize(field)
      @field = field
      move_factory = MoveFactory.new field
      moveset_factory =  MovesetFactory.new move_factory
      @pawn_move_collection_factory = PawnMoveCollectionFactory.new moveset_factory
      @king_move_collection_factory = KingMoveCollectionFactory.new moveset_factory
      @queen_move_collection_factory = QueenMoveCollectionFactory.new moveset_factory
      @bishop_move_collection_factory = BishopMoveCollectionFactory.new moveset_factory
      @knight_move_collection_factory = KnightMoveCollectionFactory.new moveset_factory
      @rook_move_collection_factory = RookMoveCollectionFactory.new moveset_factory
    end

    def create_move_collections(side_color)
      move_collections = []

      @field.figures(color: side_color).each do |figure|
        move_collection = create_move_collection figure
        move_collections.push move_collection
      end

      move_collections
    end

    def create_move_collection(figure)
      case figure
      when Pawn then @pawn_move_collection_factory.create figure
      when King then @king_move_collection_factory.create figure
      when Queen then @queen_move_collection_factory.create figure
      when Bishop then @bishop_move_collection_factory.create figure
      when Knight then @knight_move_collection_factory.create figure
      when Rook then @rook_move_collection_factory.create figure
      else
        raise "Figure with class #{figure.class} doesn`t exist!"
      end
    end
  end
end