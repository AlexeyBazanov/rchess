class Turn
  attr_reader :number

  def initialize
    @number = 1
  end

  def next
    @number += 1
  end

  def prev
    @number -= 1 if @number > 1
  end

  def color
    @number.odd? ? ColorFactory.create_white : ColorFactory.create_black
  end
end