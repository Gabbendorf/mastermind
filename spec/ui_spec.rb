require 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/peg_colour'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:peg_colour) {PegColour.new("blue")}

  it "prints the game logo" do
    output = double("output")
    ui = Ui.new(input, output)
    expect(output).to receive(:puts).with(Ui::LOGO)
    ui.print_logo
  end

  it "gets colour from codemaker for code pattern" do
    input = StringIO.new("grey\nviolet\ngreen\n")
    ui = Ui.new(input, output)

    peg = ui.choose_code_pattern_colour(peg_colour.prepare_list)

    expect(output.string).to include("Choose a colour from the following (colours can be repeated):")
    expect(output.string).to include("green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  it "confirms computer chose a code pattern" do
    ui.confirm_computer_chose_pattern

    expect(output.string).to include("A code pattern is ready.")
  end

end
