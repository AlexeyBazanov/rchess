module Rchess
  class KingMoveCollectionFactory < MoveCollectionFactory
    def create(figure)
      directions = MoveDirectionFactory::create_all
      moves = @moveset_factory.create_by_directions figure.position, directions, cells_limit: 1
      MoveCollection.new figure, moves
    end
  end
end