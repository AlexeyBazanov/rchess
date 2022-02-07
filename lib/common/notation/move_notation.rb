class MoveNotation < AbstractNotation
  TAKING = 'x'
  QUIET = '—'
  CHECK = '+'
  MATE = '++'
  DRAW = '='

  def initialize(move)
    @sign = move_to_sign move
  end

  private

  def move_to_sign(move)
    # TODO дописать нотации для хода (превращение пешки, взятие на проходе, шах, мат и пр.)
    move_type = if move.has_attacked_figure? then TAKING else QUIET end
    "#{move.figure.notation}#{move.position_from.to_s}#{move_type}#{move.position_to.to_s}"
  end
end