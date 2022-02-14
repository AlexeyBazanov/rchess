module Rchess
  class FenFieldNotation < AbstractNotation
    def initialize(field)
      get_field_sign field
    end

    protected

    def get_field_sign(field)
      sign = ''
      empty_counter = 0
      row_counter = 0

      field.each_cell_right_top do |cell|
        cell_sign = get_cell_sign cell

        if row_counter == 8
          row_counter = 0

          if empty_counter > 0
            sign += empty_counter.to_s
            empty_counter = 0
          end

          sign += FenNotation::NEW_LINE
        end

        if cell_sign
          if empty_counter > 0
            sign += empty_counter.to_s
            empty_counter = 0
          end
          sign += cell_sign
        else
          empty_counter += 1
        end

        row_counter += 1
      end

      @sign = sign
    end

    def get_cell_sign(cell)
      cell.has_figure? ? cell.figure.notation.to_s : false
    end
  end
end
