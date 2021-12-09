class MoveValidator
  attr_reader :field

  def initialize(field)
    @field = field
  end

  def validate(turn, round)
    true
  end
end