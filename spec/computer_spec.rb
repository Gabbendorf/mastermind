require 'spec_helper'
require_relative '../lib/computer'
require_relative '../lib/ui'

RSpec.describe Computer do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:computer) {Computer.new("computer", 4)}

  it "is the codemaker and creates code pattern w/ 4 colours randomly" do
    available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]

    pattern = computer.create_code_pattern(ui)

    colour1 = pattern.colours[0].colour
    colour2 = pattern.colours[1].colour
    colour3 = pattern.colours[2].colour
    colour4 = pattern.colours[3].colour

    expect(available_colours).to include(colour1, colour2, colour3, colour4)
  end

  it "is the codebreaker and makes guess w/ 4 colours randomly" do
    available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]

    pattern = computer.make_guess

    colour1 = pattern.colours[0].colour
    colour2 = pattern.colours[1].colour
    colour3 = pattern.colours[2].colour
    colour4 = pattern.colours[3].colour

    expect(available_colours).to include(colour1, colour2, colour3, colour4)
  end

end
