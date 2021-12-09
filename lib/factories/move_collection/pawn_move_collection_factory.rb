class PawnMoveCollectionFactory < MoveCollectionFactory
  def create(figure)
    moves = create_attacking_moves(figure) + create_vertical_moves(figure)
    check_transform figure, moves
    check_taking_on_pass moves
    MoveCollection.new figure, moves
  end

  private

  def create_vertical_moves(figure)
    direction = if figure.color.white? then MoveDirectionFactory::create_up else MoveDirectionFactory::create_down end
    cells_limit = if figure.has_moved? then 1 else 2 end
    @moveset_factory.create_by_direction figure.position, direction, cells_limit: cells_limit
  end

  def create_attacking_moves(figure)
    if figure.color.white?
      directions = [MoveDirectionFactory::create_top_left, MoveDirectionFactory::create_top_right]
    else
      directions = [MoveDirectionFactory::create_down_left, MoveDirectionFactory::create_down_right]
    end
    @moveset_factory.create_by_directions figure.position, directions, cells_limit: 1
  end

  def check_transform(figure, moves)
    transform_pos_y = if figure.color.white? then Position::FINISH else Position::START end
    moves.each do |move|
      move.transform_possible! if move.position_to.y == transform_pos_y
    end
  end

  def check_taking_on_pass(moves)
    moves.each do |move|
      move.can_be_taking_on_pass! if move.has_prev_moves? and not move.figure.has_moved?
    end
  end
end