class ColorFactory
  class << self
    def create_white
      Color.new Color::WHITE
    end

    def create_black
      Color.new Color::BLACK
    end

    def create_opposite(color)
      unless color.is_a? Color
        raise ArgumentError.new 'color must be a Color class instance'
      end

      color.white? ? create_black : create_white
    end
  end
end