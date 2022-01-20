class MoveNotation < AbstractNotation
  def initialize(move)
    @sign = move_to_sign move
  end

  def self.get_properties
    Configuration.moves_notation
  end

  private

  def move_to_sign(move)
    properties = MoveNotation.get_properties
    move_type = if move.has_attacked_figure? then properties[:taking] else properties[:quiet] end
    "#{move.figure.notation}#{move.position_from.notation}#{move_type}#{move.position_to}"
  end
end