require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/colour_list'
require_relative '../lib/codebreaker'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:codebreaker) {Codebreaker.new("Gabriella", ui, 4)}
  let(:colour_list) {ColourList.new}

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

    expect(output.string).to include("Choose a colour to create the code pattern (colours can be repeated):")
    expect(output.string).to include("green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  it "confirms computer chose a code pattern" do
    ui.confirm_computer_chose_pattern

    expect(output.string).to include("The code pattern is ready.")
  end

  it "gets colour from codebreaker to make guess" do
    input = StringIO.new("grey\nviolet\ngreen\n")
    ui = Ui.new(input, output)

    peg = ui.make_guess(colour_list.prepare_list, codebreaker.name)

    expect(output.string).to include("Gabriella, make your guess: choose a colour (colours can be repeated)")
    expect(output.string).to include("green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

end
