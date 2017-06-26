require 'spec_helper'
require_relative '../lib/codebreaker'
require_relative '../lib/ui'
require_relative '../lib/colour_list'

RSpec.describe Codebreaker do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:peg_colour) {PegColour.new("green")}

  it "chooses 4 colour to make a guess" do
    input = StringIO.new("green\ngrey\nyellow\npink\nblue")
    ui = Ui.new(input, output)
    codebreaker = Codebreaker.new("Gabriella", ui, 4)
    guess = codebreaker.make_guess

    colour1 =  guess.colours[0].colour
    colour2 =  guess.colours[1].colour
    colour3 =  guess.colours[2].colour
    colour4 =  guess.colours[3].colour

    expect(colour1).to eq("green")
    expect(colour2).to eq("yellow")
    expect(colour3).to eq("pink")
    expect(colour4).to eq("blue")
  end


end
