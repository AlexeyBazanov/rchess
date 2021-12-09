class Turn
  attr_reader :color, :number

  def initialize
    @color = ColorFactory.create_white
    @number = 1
  end

  def next
    @number += 1
    change_color
  end

  private

  def change_color
    @color = ColorFactory::create_opposite @color
  end
end