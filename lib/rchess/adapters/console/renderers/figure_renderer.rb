class FigureRenderer
  attr_accessor :designations, :white_color, :black_color

  def initialize
    @designations = {
      Notation::WHITE_KING => 'K',
      Notation::BLACK_KING => 'k',
      Notation::WHITE_QUEEN => 'Q',
      Notation::BLACK_QUEEN => 'q',
      Notation::WHITE_BISHOP => 'B',
      Notation::BLACK_BISHOP => 'b',
      Notation::WHITE_KNIGHT => 'N',
      Notation::BLACK_KNIGHT => 'n',
      Notation::WHITE_ROOK => 'R',
      Notation::BLACK_ROOK => 'r',
      Notation::WHITE_PAWN => 'P',
      Notation::BLACK_PAWN => 'p',
    }
    @white_color = :white
    @black_color = :green
  end

  def render(figure)
    raise "Parameter `figure` must be an object of Figure class!" unless figure.is_a? Figure
    raise "Designation '#{figure.name}' not present in designations map!" unless @designations.include? figure.name
    output = @designations[figure.name]
    color = figure.name.upcase == figure.name ? @white_color : @black_color
    # [output, color]
    output
  end
end