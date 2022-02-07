module Rchess
  class QueenMoveCollectionFactory < MoveCollectionFactory
    def create(figure)
      directions = MoveDirectionFactory::create_all
      moves = @moveset_factory.create_by_directions figure.position, directions, cells_limit: 7
      MoveCollection.new figure, moves
    end
  end
end