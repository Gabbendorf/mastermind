require 'spec_helper'
require_relative '../lib/mastermind'
require_relative '../lib/computer'
require_relative '../lib/human_player'
require_relative '../lib/ui'
require_relative '../lib/peg_colour'
require_relative '../lib/pattern'

RSpec.describe Mastermind do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:players) {Players.new(ui)}
  let(:mastermind) {Mastermind.new(ui, players)}

  xit "runs a new game with computer as codemaker and human player as codebreaker" do
    input = StringIO.new("computer\nhuman player\ngreen\npink\nyellow\ngrey\npurple\norange\nblue\npurple\nyellow\n")
    ui = Ui.new(input, output)
    players = FakePlayers.new(ui)
    mastermind = Mastermind.new(ui, players)

    mastermind.run_game

    expect(output.string).to include("Congratulations Gabriella: YOU WON!")
  end

end

class FakeComputer

  def initialize(type, ui, pattern_size)
    @type = type
    @ui = ui
    @pattern_size = pattern_size
    @available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]
  end

  def create_code_pattern
    colours = []
    @pattern_size.times {colours.push(PegColour.new(@available_colours.pop))}
    @ui.confirm_computer_chose_pattern
    Pattern.new(colours)
  end

end

require_relative '../lib/human_player'

class  FakePlayers

  def initialize(ui)
    @ui = ui
  end

  def codemaker(input)
    if input == "computer"
      FakeComputer.new("computer", @ui, 4)
    elsif input == "human player"
      HumanPlayer.new("Gabriella", @ui, 4)
    end
  end

  def codebreaker(input)
    if input == "computer"
      FakeComputer.new("computer", @ui, 4)
    elsif input == "human player"
      HumanPlayer.new("Gabriella", @ui, 4)
    end
  end
end
