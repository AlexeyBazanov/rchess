require "zeitwerk"
require 'yaml'

src_path = File.dirname(__FILE__) + '/lib'
config_path = File.dirname(__FILE__) + '/conf'

loader = Zeitwerk::Loader.new
loader.push_dir src_path
loader.push_dir src_path + '/adapters/console/renderers'
loader.push_dir src_path + '/common/castling/patterns'

subdir_pattern = '/*'

# TODO Разобраться с автолоадером!
5.times do
  loader.collapse("#{src_path}#{subdir_pattern}")
  subdir_pattern *= 2
end

loader.enable_reloading
loader.setup

config_files = %w[main.yaml notation/figures_eng.yaml notation/moves.yaml]

# TODO вынести в отдельный модуль
class ::Hash
  def deep_merge!(second)
    merger = proc { |_, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : Array === v1 && Array === v2 ? v1 | v2 : [:undefined, nil, :nil].include?(v2) ? v1 : v2 }
    merge!(second.to_h, &merger)
  end
end

Configuration.configure do |config|
  config_files.each do |config_file|
    hashed_config = YAML.load_file "#{config_path}/#{config_file}", symbolize_names: true
    config.deep_merge! hashed_config
  end
end

# puts Configuration.settings

figure_factory = FenFigureFactory.new
field_factory = FenFieldFactory.new figure_factory
field = field_factory.create_field FenNotation::START_ARRANGEMENT

# puts field.figures[1].position

# white_figures = field.figures ColorFactory.create_black
# puts white_figures.length

# rook = Rook.new 'R', ColorFactory.create_white
# puts rook.is_a? Rook

# turn = Turn.new
# round_factory = RoundFactory.new field
# round = round_factory.create_round turn

# puts round.white_move_collections.first.figure.position.x
# puts round.white_move_collections.first.moves[6].barrier_figures

# puts round.white_move_collections.first.moves.last.barrier_figures
# puts round.white_move_collections.first.moves.first.position_from.x
# puts round.white_move_collections.first.moves.first.position_from.y
# puts round.white_move_collections.first.moves.first.position_to.x
# puts round.white_move_collections.first.moves.first.position_to.y

#
# pattern = WhiteKingSideCastlingPattern.new
# puts pattern

# puts field.cells
# puts FenNotation::ROOK_SIGNS.class

# puts Configuration::settings.notation.figures.signs.white_king

# field = FieldFactory::create_by_notation Notation::START_ARRANGEMENT
# field_renderer = FieldRenderer.new

# puts field_renderer.render field

# puts field