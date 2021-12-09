class MoveProhibitionFactory
  class << self
    def create_figure_not_present
      MoveProhibition.new 'Figure not present'
    end

    def create_figure_already_move
      MoveProhibition.new 'Figure already move'
    end

    def create_cell_not_free
      MoveProhibition.new 'Cell for move not free'
    end

    def create_check_king_move
      MoveProhibition.new 'This is a check move'
    end
  end
end