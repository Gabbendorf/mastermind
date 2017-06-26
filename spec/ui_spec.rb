require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/colour_list'
require_relative '../lib/codebreaker'
require_relative '../lib/pattern'
require_relative '../lib/result'
require_relative '../lib/feedback'
require_relative '../lib/board'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:codebreaker) {Codebreaker.new("Gabriella", ui, 4)}
  let(:colour_list) {ColourList.new}
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

    peg = ui.choose_code_pattern_colour(colour_list.prepare_list)

    expect(output.string).to include("Choose a colour to create the code pattern (colours can be repeated):",
                                      "green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  it "confirms computer chose a code pattern" do
    ui.confirm_computer_chose_pattern

    expect(output.string).to include("The code pattern is ready. The challenge begins!")
  end

  it "gets colour from codebreaker to make guess" do
    input = StringIO.new("grey\nviolet\ngreen\n")
    ui = Ui.new(input, output)

    peg = ui.make_guess(colour_list.prepare_list, codebreaker.name)

    expect(output.string).to include("Gabriella, make your guess: choose a colour (colours can be repeated)")
    expect(output.string).to include("green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  def set_up_result(colours, red, white)
    guess = Pattern.new(colours)
    feedback = Feedback.new(red, white)
    Result.new(guess, feedback)
  end

  it "prints an history after each guess" do
    result1 = set_up_result(["red", "blue", "yellow", "green"], 1, 2)
    result2 = set_up_result(["blue", "blue", "pink", "green"], 3, 0)
    board.keep_track_of_results(result1)
    board.keep_track_of_results(result2)

    ui.print_history(board.history, board)

    expect(output.string).to include("GUESS: red, blue, yellow, green. FEEDBACK: 1 red peg/s, 2 white peg/s.\n",
                                      "GUESS: blue, blue, pink, green. FEEDBACK: 3 red peg/s, 0 white peg/s.\n")
  end

end
