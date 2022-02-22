module Rchess
  class History
    def initialize
      @movables = []
      @tail = -1
    end

    def has_movables?
      @tail > -1
    end

    def add_movable(movable)
      if @tail < @movables.length - 1
        movables = has_movables? ? @movables[0..@tail] : []
        @movables = movables
      end
      @movables.append movable
      @tail += 1
    end

    def prev
      return unless has_movables?
      movable = @movables[@tail]
      @tail -= 1
      movable
    end

    def next
      return if @tail >= @movables.length - 1
      @tail += 1
      @movables[@tail]
    end

    def movables
      @movables.map.with_index { |movable, index| "#{index+1}. #{movable.notation}" }
    end

    def white_taken_figures
      taken_figures_history ColorFactory.create_white
    end

    def black_taken_figures
      taken_figures_history ColorFactory.create_black
    end

    def taken_figures(color=nil)
      taken_figures_list(color).map { |figure| "#{figure.notation}"}
    end

    protected

    def taken_figures_list(color=nil)
      taken_figures = []
      @movables.each do |movable|
        next if movable.is_a? Castling
        is_color_suit = color.nil? ? true : movable.attacked_figure.color.same?(color)
        if movable.has_attacked_figure? and is_color_suit
          taken_figures << movable.attacked_figure
        end
      end
      taken_figures
    end
  end
end