require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/board'
require_relative '../lib/pattern'
require_relative '../lib/peg_colour'
require_relative '../lib/ui'
require_relative '../lib/human_player'
require_relative '../lib/result'

RSpec.describe UnbeatableComputer do

  def set_up_result(guess)
    red_pegs = 2
    white_pegs = 0
    feedback = Feedback.new(red_pegs, white_pegs)
    Result.new(guess, feedback)
  end

  def set_up_pattern
    colour_strings = ['green', 'yellow', 'pink', 'blue']
    peg_colours = colour_strings.map {|colour| PegColour.new(colour)}
    Pattern.new(peg_colours)
  end

  let(:code_pattern) {set_up_pattern}
  let(:board) {Board.new(8, code_pattern)}
  let(:unbeatable_computer) {UnbeatableComputer.new("smart computer", 4, board)}

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

  it "guesses correctly within given number of guesses" do
    def make_guess_until_win
      guess = unbeatable_computer.make_guess
      feedback = code_pattern.compare(guess)
      new_result = Result.new(guess, feedback)
      board.keep_track_of_results(new_result)
      if !board.game_over?
        make_guess_until_win
      end
    end

    make_guess_until_win

    expect(board.verdict).to eq(:codebreaker_wins)
  end

end
