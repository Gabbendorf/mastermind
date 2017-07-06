require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/board'
require_relative '../lib/pattern'
require_relative '../lib/peg_colour'

RSpec.describe UnbeatableComputer do

  def set_up_result(guess)
    red_pegs = 2
    white_pegs = 0
    feedback = Feedback.new(red_pegs, white_pegs)
    Result.new(guess, feedback)
  end

  def set_up_pattern(colour_strings)
    peg_colours = colour_strings.map {|colour| PegColour.new(colour)}
    Pattern.new(peg_colours)
  end

  let(:pattern) {double}
  let(:board) {Board.new(8, pattern)}
  let(:unbeatable_computer) {UnbeatableComputer.new(4, board)}

  it "gives 2 choices of same colour and 2 of another colour for 1st guess" do
    first_guess = unbeatable_computer.make_guess

    first_colour = first_guess.colours[0].colour
    second_colour = first_guess.colours[2].colour

    first_guess_colours = first_guess.colours.map(&:colour)
    expect(first_guess_colours).to eq([first_colour, first_colour, second_colour, second_colour])
  end

  it "gives a random guess from possible patterns for guess 2 onwards" do
    first_guess = unbeatable_computer.make_guess
    board.keep_track_of_results(set_up_result(first_guess))
    second_guess = unbeatable_computer.make_guess

    first_colour = second_guess.colours[0].colour
    second_colour = second_guess.colours[1].colour
    third_colour = second_guess.colours[2].colour
    fourth_colour = second_guess.colours[3].colour

    second_guess_colours = second_guess.colours.map(&:colour)
    expect(second_guess_colours).to eq([first_colour, second_colour, third_colour, fourth_colour])
  end

  # it "generates all possible patterns" do
  #   unbeatable_computer.generate_all_possible_patterns
  #
  #   demonstrated_possible_patterns_number = 1296
  #
  #   expect(unbeatable_computer.possible_patterns.size).to eq(demonstrated_possible_patterns_number)
  # end
  #
end
