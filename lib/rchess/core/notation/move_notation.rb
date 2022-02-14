module Rchess
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
      move_type = move.has_attacked_figure? ? TAKING : QUIET
      "#{move.figure.notation unless move.figure.is_a? Pawn}#{move.position_from.notation}#{move_type}#{move.position_to.notation}"
    end
  end
end
