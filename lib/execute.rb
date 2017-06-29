require_relative 'ui'
require_relative 'computer'
require_relative 'human_player'
require_relative 'mastermind'
require_relative 'players'

ui = Ui.new($stdin, $stdout)
codemaker = Computer.new("computer", 4)
codebreaker = HumanPlayer.new("Gabriella", ui, 4)
mastermind = Mastermind.new(ui, codemaker, codebreaker)

mastermind.run_game
