require 'spec_helper'
require_relative '../lib/mastermind'
require_relative '../lib/computer'
require_relative '../lib/human_player'
require_relative '../lib/ui'
require_relative '../lib/peg_colour'
require_relative '../lib/pattern'
require_relative '../lib/board'
require_relative '../lib/unbeatable_computer'

RSpec.describe Mastermind do

  let(:pattern) {double}
  let(:board) {Board.new(8, pattern)}
  let(:output) {StringIO.new}

  xit "runs a new game with computer as codemaker and human player as codebreaker" do
    input = StringIO.new("c\nh\nGabriella\norange\nblue\npurple\nyellow\n")
    ui = Ui.new(input, output)
    players = FakePlayers.new(ui)
    mastermind = Mastermind.new(ui, players)

    mastermind.run_game

    expect(output.string).to include("Gabriella wins!")
  end

  xit "runs a new game with human player as codemaker and computer as codebreaker" do
    input = StringIO.new("h\nc\norange\nblue\npurple\nyellow\n")
    ui = Ui.new(input, output)
    players = FakePlayers.new(ui)
    mastermind = Mastermind.new(ui, players)

    mastermind.run_game

    expect(output.string).to include("computer wins!")
  end

end

class FakeComputer

  attr_reader :name

  def initialize(name, pattern_size)
    @name = name
    @pattern_size = pattern_size
    @available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]
  end

  def create_code_pattern(ui)
    colours = []
    @pattern_size.times {colours.push(PegColour.new(@available_colours.pop))}
    ui.confirm_computer_chose_pattern
    Pattern.new(colours)
  end

  def make_guess
    guess = []
    @pattern_size.times {guess.push(PegColour.new(@available_colours.pop))}
    Pattern.new(guess)
  end

end

class  FakePlayers

  def initialize(ui)
    @ui = ui
  end

  def codemaker(input)
    if input == "c"
      FakeComputer.new("computer", 4)
    elsif input == "h"
      HumanPlayer.new("Gabriella", @ui, 4)
    end
  end

  def codebreaker(input, board)
    if input == "c"
      FakeComputer.new("computer", 4)
    elsif input == "h"
      HumanPlayer.new("Gabriella", @ui, 4)
    elsif input == "s"
      UnbeatableComputer.new("smart computer", 4, board)
    end
  end
end
