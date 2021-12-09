class FenFieldFactory < AbstractFieldFactory
  def create_field(fen_notation)
    field = Field.new
    x = Position::START
    y = Position::FINISH

    fen_notation.split('').each do |sign|
      position = PositionFactory::create_by_coordinates x, y
      if FenNotation::figure? sign
        place_figure sign, position, field
        x += 1
      elsif FenNotation::coordinate? sign
        x += sign.to_i
      elsif FenNotation::new_line? sign
        y -= 1
        x = 0
      else
        raise "Invalid fen notation sign '#{sign}'!"
      end
    end

    field
  end

  private

  def place_figure(notation_sign, position, field)
    figure = @figure_factory.create_figure notation_sign
    field.set_figure(figure, position) if figure
  end
end