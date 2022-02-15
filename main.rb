require "zeitwerk"

src_path = Dir.pwd + '/lib'
loader = Zeitwerk::Loader.new

loader.push_dir src_path
loader.collapse("#{src_path}/rchess/core")
loader.collapse("#{src_path}/rchess/game_logic")
loader.collapse("#{src_path}/rchess/core/castling")
loader.collapse("#{src_path}/rchess/core/castling/patterns")
loader.collapse("#{src_path}/rchess/core/figures")
loader.collapse("#{src_path}/rchess/core/move")
loader.collapse("#{src_path}/rchess/core/notation")
loader.collapse("#{src_path}/rchess/factories")
loader.collapse("#{src_path}/rchess/factories")
loader.collapse("#{src_path}/rchess/factories/castling")
loader.collapse("#{src_path}/rchess/factories/field")
loader.collapse("#{src_path}/rchess/factories/figure")
loader.collapse("#{src_path}/rchess/factories/move_collection")
loader.collapse("#{src_path}/rchess/factories/party")
loader.collapse("#{src_path}/rchess/move_validators")

loader.setup

include Rchess

party_factory = FenPartyFactory.new
party = party_factory.create FenNotation::START_ARRANGEMENT
party.start
puts party.current_notation
party.do_move 'e2', 'e4'
party.do_move 'd7', 'd5'
party.do_move 'e4', 'd5'
puts party.current_notation
party.undo_move
party.undo_move
party.do_move 'd7', 'd6'
puts party.current_player_color
puts party.current_notation

# party.redo_move
# party.redo_move
# party.redo_move
# puts party.current_notation
# party.move_log.moves_history.each { |move| puts move }
# party.move_log.taken_figures_history.each { |move| puts move }

# puts party.current_notation

# require 'yaml'
#
# src_path = File.dirname(__FILE__) + '/lib'
# config_path = File.dirname(__FILE__) + '/conf'
#
# loader = Zeitwerk::Loader.new
# loader.push_dir src_path
# loader.push_dir src_path + '/adapters/console/renderers'
# loader.push_dir src_path + '/common/castling/patterns'
#
# subdir_pattern = '/*'
#
# # TODO Разобраться с автолоадером!
# 5.times do
#   loader.collapse("#{src_path}#{subdir_pattern}")
#   subdir_pattern *= 2
# end
#
# loader.enable_reloading
# loader.setup
#
# config_files = %w[main.yaml notation/figures_eng.yaml notation/moves.yaml]
#
# # TODO вынести в отдельный модуль
# class ::Hash
#   def deep_merge!(second)
#     merger = proc { |_, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : Array === v1 && Array === v2 ? v1 | v2 : [:undefined, nil, :nil].include?(v2) ? v1 : v2 }
#     merge!(second.to_h, &merger)
#   end
# end
#
# Configuration.configure do |config|
#   config_files.each do |config_file|
#     hashed_config = YAML.load_file "#{config_path}/#{config_file}", symbolize_names: true
#     config.deep_merge! hashed_config
#   end
# end

# puts Configuration.settings

# figure_factory = FenFigureFactory.new
# field_factory = FenFieldFactory.new figure_factory
# field = field_factory.create_field FenNotation::START_ARRANGEMENT

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
#

# position = Position.new 11, 11
#


