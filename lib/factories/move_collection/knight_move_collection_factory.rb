class KnightMoveCollectionFactory < MoveCollectionFactory
  def create(figure)
    moves = @moveset_factory.create_by_offset figure.position, offset_x: 1, offset_y: 2
    MoveCollection.new figure, moves
  end
end