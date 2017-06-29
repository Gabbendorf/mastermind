require 'spec_helper'
require 'human_player'
require 'ui'
require 'colour_list'

RSpec.describe HumanPlayer do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:peg_colour) {PegColour.new("green")}

  it "is the codemaker and creates code pattern w/ 4 colours" do
    input = StringIO.new("green\ngrey\nyellow\npink\nblue")
    ui = Ui.new(input, output)
    codemaker = HumanPlayer.new("Gabriella", ui, 4)

    code_pattern = codemaker.create_code_pattern

    colour1 =  code_pattern.colours[0].colour
    colour2 =  code_pattern.colours[1].colour
    colour3 =  code_pattern.colours[2].colour
    colour4 =  code_pattern.colours[3].colour

    expect(colour1).to eq("green")
    expect(colour2).to eq("yellow")
    expect(colour3).to eq("pink")
    expect(colour4).to eq("blue")
  end

  it "is the codebreaker and makes guess w/ 4 colours" do
    input = StringIO.new("green\ngrey\nyellow\npink\nblue")
    ui = Ui.new(input, output)
    human = HumanPlayer.new("Gabriella", ui, 4)

    guess = human.make_guess

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
