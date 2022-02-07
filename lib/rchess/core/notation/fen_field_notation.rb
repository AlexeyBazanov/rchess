module Rchess
  class FenFieldNotation < AbstractNotation
    def initialize(field)
      @sign = get_field_sign field
    end

    def get_field_sign(field)
      sign = ''
      empty_counter = 0
      row_counter = 0

      field.each_cell do |cell|
        cell_sign = get_cell_sign cell

        if cell_sign
          if empty_counter
            sign += empty_counter.to_s
          end
          sign += cell_sign
        else
          empty_counter += 1
        end

        row_counter += 1

        if row_counter == 7
          row_counter = 0
          sign += FenNotation::NEW_LINE
        end
      end
    end

    def get_cell_sign(cell)
      cell.has_figure? ? cell.figure.notation.to_s : false
    end
  end
end
