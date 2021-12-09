require "zeitwerk"
require 'yaml'

src_path = File.dirname(__FILE__) + '/lib'
config_path = File.dirname(__FILE__) + '/conf'

loader = Zeitwerk::Loader.new
loader.push_dir src_path
loader.push_dir src_path + '/adapters/console/renderers'

subdir_pattern = '/*'

# TODO Разобраться с автолоадером!
5.times do
  loader.collapse("#{src_path}#{subdir_pattern}")
  subdir_pattern *= 2
end

loader.enable_reloading
loader.setup

config_files = %w[main.yaml notation/moves.yaml notation/figures_eng.yaml]

Configuration.configure do |config|
  config_files.each do |config_file|
    hashed_config = YAML.load_file "#{config_path}/#{config_file}", symbolize_names: true
    config.merge! hashed_config
  end
end

figure_factory = FenFigureFactory.new
field_factory = FenFieldFactory.new figure_factory
field = field_factory.create_field FenNotation::START_ARRANGEMENT

# puts field.cells
# puts FenNotation::ROOK_SIGNS.class

# puts Configuration::settings.notation.figures.signs.white_king

# field = FieldFactory::create_by_notation Notation::START_ARRANGEMENT
# field_renderer = FieldRenderer.new

# puts field_renderer.render field

# puts field