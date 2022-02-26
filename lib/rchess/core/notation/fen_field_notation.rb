module Rchess
  # TODO rnb1kbnr/ppp2ppp/3q4/1B1pp3/4P3/5N2/PPPP1PPP/RNBQ1RK
  class FenFieldNotation < AbstractNotation
    COLS_IN_ROW = 8

    def initialize(field)
      @sign = get_field_sign field
    end

    protected

    def get_field_sign(field)
      field_sign = ''
      empty_cells = 0
      row_counter = 0

      field.each_cell_left_top do |cell|
        figure_sign = get_figure_sign cell

        if row_counter == COLS_IN_ROW
          row_counter = 0

          if empty_cells > 0
            field_sign += empty_cells.to_s
            empty_cells = 0
          end

          field_sign += FenNotation::NEW_LINE
        end

        if figure_sign
          if empty_cells > 0
            field_sign += empty_cells.to_s
            empty_cells = 0
          end
          field_sign += figure_sign
        else
          empty_cells += 1
        end

        row_counter += 1
      end

      if row_counter == COLS_IN_ROW && empty_cells.positive?
        field_sign += empty_cells.to_s
      end

      field_sign
    end

    protected

    def get_figure_sign(cell)
      cell.has_figure? ? cell.figure.notation.to_s : false
    end
  end
end
