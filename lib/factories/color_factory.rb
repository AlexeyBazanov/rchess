class ColorFactory
  class << self
    def create_white
      Color.new Color::WHITE
    end

    def create_black
      Color.new Color::BLACK
    end

    def create_opposite(color)
      if color.white? then create_black else create_white end
    end
  end
end