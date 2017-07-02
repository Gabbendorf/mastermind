require 'spec_helper'
require 'human_player'
require 'ui'
require 'colour_list'

RSpec.describe HumanPlayer do

  it "is the codemaker and chooses 4 colours to create code pattern" do
    input_colours = ['green', 'yellow', 'pink', 'blue']
    input = StringIO.new(input_colours.join("\n"))
    output = StringIO.new
    ui = Ui.new(input, output)
    codemaker = HumanPlayer.new("Gabriella", ui, 4)

    code_pattern = codemaker.create_code_pattern

    code_pattern_colours = code_pattern.colours.map(&:colour)
    expect(code_pattern_colours).to match_array(input_colours)
  end

  it "is the codebreaker and chooses 4 colours to make a guess" do
    input_colours = ['green', 'yellow', 'pink', 'blue']
    input = StringIO.new(input_colours.join("\n"))
    output = StringIO.new
    ui = Ui.new(input, output)
    codebreaker = HumanPlayer.new("Gabriella", ui, 4)

    guess = codebreaker.make_guess

    guess_colours = guess.colours.map(&:colour)
    expect(guess_colours).to match_array(input_colours)
  end


end
