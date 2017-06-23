require 'spec_helper'
require_relative '../lib/ui'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}

  it "prints the game logo" do
    output = double("output")
    ui = Ui.new(input, output)
    expect(output).to receive(:puts).with(Ui::LOGO)
    ui.print_logo
  end

  it "gets colour from codemaker for colour pattern" do
    input = StringIO.new("green\n")
    ui = Ui.new(input, output)

    colour = ui.choose_pattern_colour

    expect(output.string).to include("Choose a colour for the pattern:")
    expect(colour).to eq("green")
  end

  it "asks codemaker to repeat colour for colour pattern" do
    input = StringIO.new("green")
    ui = Ui.new(input, output)

    colour = ui.repeat_pattern_colour

    expect(output.string).to include("Colour not available, choose another colour:")
    expect(colour).to eq("green")
  end

  it "confirms computer chose a colour pattern" do
    ui.confirm_computer_chose_pattern

    expect(output.string).to include("Computer chose a pattern.")
  end

end
