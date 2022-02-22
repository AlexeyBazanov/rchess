require 'zeitwerk'
require_relative 'rchess/version'

loader = Zeitwerk::Loader.new
loader.tag = File.basename(__FILE__, ".rb")
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(__dir__)
loader.collapse("#{__dir__}/rchess/core")
loader.collapse("#{__dir__}/rchess/core/castling")
loader.collapse("#{__dir__}/rchess/core/castling/patterns")
loader.collapse("#{__dir__}/rchess/core/figures")
loader.collapse("#{__dir__}/rchess/core/move")
loader.collapse("#{__dir__}/rchess/core/notation")
loader.collapse("#{__dir__}/rchess/factories")
loader.collapse("#{__dir__}/rchess/factories/castling")
loader.collapse("#{__dir__}/rchess/factories/field")
loader.collapse("#{__dir__}/rchess/factories/figure")
loader.collapse("#{__dir__}/rchess/factories/move_collection")
loader.collapse("#{__dir__}/rchess/factories/party")
loader.collapse("#{__dir__}/rchess/move_validators")
loader.collapse("#{__dir__}/rchess/services")
loader.collapse("#{__dir__}/rchess/game_logic")
loader.setup
