class PositionNotation < AbstractNotation
  LETTERS = %w[a b c d e f g h]
  COORDINATES = %w[1 2 3 4 5 6 7 8]

  def initialize(position)
    @sign = position_to_sign position
  end

  private

  def position_to_sign(position)
    "#{LETTERS.at(position.x)}#{position.y+1}"
  end
end