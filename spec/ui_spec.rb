require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/codebreaker'
require_relative '../lib/pattern'
require_relative '../lib/result'
require_relative '../lib/feedback'
require_relative '../lib/board'
require_relative '../lib/peg_colour'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:codebreaker) {Codebreaker.new("Gabriella", ui, 4)}
  let(:board) {Board.new(8, ["green", "pink", "green", "blue"])}

  it "prints the game logo" do
    output = double("output")
    ui = Ui.new(input, output)
    expect(output).to receive(:puts).with(Ui::LOGO)
    ui.print_logo
  end

  it "gets colour from codemaker for code pattern" do
    input = StringIO.new("grey\nviolet\ngreen\n")
    ui = Ui.new(input, output)

    peg = ui.choose_code_pattern_colour

    expect(output.string).to include("Choose a colour to create the code pattern (colours can be repeated):",
                                      "green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  it "confirms computer chose a code pattern" do
    ui.confirm_computer_chose_pattern

    expect(output.string).to include("The code pattern is ready. The challenge begins!", "")
  end

  it "gets colour from codebreaker to make guess" do
    input = StringIO.new("grey\nviolet\ngreen\n")
    ui = Ui.new(input, output)

    peg = ui.make_guess(codebreaker.name)

    expect(output.string).to include("Gabriella, make your guess: choose a colour (colours can be repeated)")
    expect(output.string).to include("green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  def set_up_result(colour_strings, red_pegs, white_pegs)
    peg_colours = colour_strings.map {|colour| PegColour.new(colour)}
    guess = Pattern.new(peg_colours)
    feedback = Feedback.new(red_pegs, white_pegs)
    Result.new(guess, feedback)
  end

  it "prints an history after each guess" do
    result1 = set_up_result(["purple", "blue", "yellow", "green"], 1, 2)
    result2 = set_up_result(["blue", "blue", "pink", "green"], 3, 0)
    board.keep_track_of_results(result1)
    board.keep_track_of_results(result2)

    ui.print_history(board.history, board)

    expect(output.string).to include("GUESS: purple, blue, yellow, green. FEEDBACK: 1 red peg/s, 2 white peg/s.\n",
                                      "GUESS: blue, blue, pink, green. FEEDBACK: 3 red peg/s, 0 white peg/s.\n")
  end

  it "prings message for winner" do
    ui.declare_winner(codebreaker.name)

    expect(output.string).to include("Congratulations Gabriella: YOU WON!")
  end

  it "prings message for loser" do
    ui.declare_loser(codebreaker.name)

    expect(output.string).to include("Gabriella: GAME OVER!")
  end

end
