require "zeitwerk"

src_path = Dir.pwd + '/lib'
loader = Zeitwerk::Loader.new

loader.push_dir src_path
loader.collapse("#{src_path}/rchess/core")
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
loader.collapse("#{src_path}/rchess/move_validators")

loader.setup

include Rchess
