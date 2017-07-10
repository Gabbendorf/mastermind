require_relative 'ui'
require_relative 'mastermind'
require_relative 'players'

ui = Ui.new($stdin, $stdout)
players = Players.new(ui)
mastermind = Mastermind.new(ui, players)

mastermind.run_game
