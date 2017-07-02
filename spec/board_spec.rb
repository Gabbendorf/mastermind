require 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/feedback'
require_relative '../lib/pattern'
require_relative '../lib/result'
require_relative '../lib/peg_colour'

RSpec.describe Board do

  let(:pattern) {double}
  let(:board) {Board.new(8, pattern)}

  def set_up_result(red_pegs, white_pegs)
    colour_strings = ["green", "blue", "purple", "green"]
    peg_colours = colour_strings.map {|colour| PegColour.new(colour)}
    guess = Pattern.new(peg_colours)
    feedback = Feedback.new(red_pegs, white_pegs)
    Result.new(guess, feedback)
  end

  it "no result history at the start" do
    expect(board.history).to be_empty
  end

  it "keeps track of first result" do
    result = set_up_result(1, 2)

    board.keep_track_of_results(result)

    expect(board.history).to eq([result])
  end

  it "keeps track of following result" do
    first_result = set_up_result(1, 2)
    second_result = set_up_result(1, 2)

    board.keep_track_of_results(first_result)
    board.keep_track_of_results(second_result)

    expect(board.history).to eq([first_result, second_result])
  end

  it "returns strings as hash values for guess and feedback of each result" do
    result = set_up_result(1, 2)
    board.keep_track_of_results(result)

    guess = board.printable_history(board.history[0])[:guess]
    red_pegs = board.printable_history(board.history[0])[:red_pegs]
    white_pegs = board.printable_history(board.history[0])[:white_pegs]

    expect(guess).to eq("green, blue, purple, green")
    expect(red_pegs).to eq("1")
    expect(white_pegs).to eq("2")
  end

  it "knows game is over if player runs out of the 8 possible guesses" do
    8.times {board.keep_track_of_results([[:guess], [:feedback]])}

    expect(board.game_over?).to eq(true)
  end

  it "knows game is over when feedback returns 4 red pegs" do
    red_pegs = 4
    white_pegs = 0
    result = set_up_result(red_pegs, white_pegs)

    board.keep_track_of_results(result)

    expect(board.game_over?).to eq(true)
  end

  it "returns :lost if 8 chances to guess ran out" do
    8.times {board.keep_track_of_results([[:guess], [:feedback]])}

    expect(board.verdict).to eq(:lost)
  end

  it "returns :won if codebreaker guesses all 4 colours correctly" do
    result = set_up_result(4, 0)
    board.keep_track_of_results(result)

    expect(board.verdict).to eq(:won)
  end

end
