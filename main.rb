require 'ruby-prof'
require 'benchmark'
require 'byebug'
require_relative 'lib/rchess'

party = Rchess::Chess.continue_party 'rnb1kbnr/ppp2ppp/3q4/1B1pp3/4P3/5N2/PPPP1PPP/RNBQ1RK1'
party.start
puts party.current_notation




