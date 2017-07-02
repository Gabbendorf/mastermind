require_relative 'ui'
require_relative 'codemaker'
require_relative 'codebreaker'
require_relative 'mastermind'

ui = Ui.new($stdin, $stdout)
codemaker = Codemaker.new("computer", 4)
codebreaker = Codebreaker.new("Gabriella", ui, 4)
mastermind = Mastermind.new(ui, codemaker, codebreaker)

mastermind.run_game
