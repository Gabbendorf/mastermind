require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/board'

RSpec.describe UnbeatableComputer do

  let(:pattern) {double}
  let(:board) {Board.new(8, pattern)}
  let(:unbeatable_computer) {UnbeatableComputer.new(4, board)}

  it "gives 2 choices of same colour and 2 of another colour as 1st guess" do
    first_guess = unbeatable_computer.make_guess

    first_colour = first_guess.colours[0].colour
    second_colour = first_guess.colours[2].colour

    first_guess_colours = first_guess.colours.map(&:colour)
    expect(first_guess_colours).to eq([first_colour, first_colour, second_colour, second_colour])
  end

  it "generates all possible patterns" do
    unbeatable_computer.generate_all_possible_patterns

    demonstrated_possible_patterns_number = 1296

    expect(unbeatable_computer.possible_patterns.size).to eq(demonstrated_possible_patterns_number)
  end

end
