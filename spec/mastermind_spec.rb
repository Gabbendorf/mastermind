require 'spec_helper'
require_relative '../lib/mastermind'
require_relative '../lib/computer'
require_relative '../lib/human_player'
require_relative '../lib/ui'
require_relative '../lib/peg_colour'
require_relative '../lib/pattern'
require_relative '../lib/board'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/players'

RSpec.describe Mastermind do

  let(:output) {StringIO.new}

  it "runs a new game with computer as codemaker and human player as codebreaker" do
    input = StringIO.new("c\nh\nGabriella\norange\nblue\npurple\nyellow\n")
    ui = Ui.new(input, output)
    players = FakePlayers.new(ui)
    mastermind = Mastermind.new(ui, players)

    mastermind.run_game

    expect(output.string).to include("Gabriella wins!")
  end

  it "runs a new game with human player as codemaker and computer as codebreaker" do
    input = StringIO.new("h\nGabriella\norange\nblue\npurple\nyellow\nc")
    ui = Ui.new(input, output)
    players = FakePlayers.new(ui)
    mastermind = Mastermind.new(ui, players)

    mastermind.run_game

    expect(output.string).to include("computer wins!")
  end

  xit "runs a new game with human player as codemaker and smart computer as codebreaker" do
    input = StringIO.new("h\nGabriella\norange\nblue\npurple\nyellow\ns")
    ui = Ui.new(input, output)
    players = FakePlayers.new(ui)
    mastermind = Mastermind.new(ui, players)

    mastermind.run_game

    expect(output.string).to include("smart computer wins!")
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

class FakeUnbeatableComputer

  attr_reader :name

  def initialize(name, pattern_size, board)
    @name = name
    @pattern_size = pattern_size
    @board = board
    @first_guess_colours = ["green", "green", "blue", "blue"]
    @available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]
  end

  def make_guess
    if empty_board_history?
      make_first_guess
    else
      make_next_guess
    end
  end

  private

  def make_first_guess
    guess = []
    @first_guess_colours.each {|colour| guess.push(PegColour.new(colour))}
    Pattern.new(guess)
  end

  def make_next_guess
    guess = []
    @pattern_size.times {guess.push(PegColour.new(@available_colours.pop))}
    Pattern.new(guess)
  end

  def empty_board_history?
    @board.history.size == 0
  end
end

class  FakePlayers

  def initialize(ui)
    @ui = ui
    @board = Board.new(8, @pattern)
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
      FakeUnbeatableComputer.new("smart computer", 4, @board)
    end
  end
end
