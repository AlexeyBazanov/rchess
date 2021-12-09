class Color
  WHITE = 'white'
  BLACK = 'black'

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def white?
    name == WHITE
  end

  def same?(color)
    color.name == name
  end

  def opposite
    if white? then Color.new(BLACK) else Color.new(WHITE) end
  end
end