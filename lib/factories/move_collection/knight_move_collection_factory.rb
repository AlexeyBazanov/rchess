class KnightMoveCollectionFactory < MoveCollectionFactory
  def create(figure)
    moves = @moveset_factory.create_by_offsets figure.position, axis_one_offset: 1, axis_two_offset: 2
    MoveCollection.new figure, moves
  end
end