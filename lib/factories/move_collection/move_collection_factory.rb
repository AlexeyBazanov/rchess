class MoveCollectionFactory
  attr_reader :moveset_factory

  def initialize(moveset_factory)
    @moveset_factory = moveset_factory
  end

  def create(figure); end
end