require 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/feedback'
require_relative '../lib/pattern'
require_relative '../lib/result'
require_relative '../lib/peg_colour'

RSpec.describe Board do

  let(:board) {Board.new(8, ["green", "pink", "green", "blue"])}

  def set_up_result(colour_strings, red_pegs, white_pegs)
    peg_colours = colour_strings.map {|colour| PegColour.new(colour)}
    guess = Pattern.new(peg_colours)
    feedback = Feedback.new(red_pegs, white_pegs)
    Result.new(guess, feedback)
  end

  it "registers a result containing guess and feedback" do
    result = set_up_result(["green", "blue", "purple", "green"], 1, 2)

    board.keep_track_of_results(result)

    expect(board.history).to eq([result])
  end

  it "returns strings as hash values for guess and feedback of each result" do
    result = set_up_result(["green", "blue", "purple", "green"], 0, 3)
    board.keep_track_of_results(result)

    guess = board.printable_history(board.history[0])[:guess]
    red_pegs = board.printable_history(board.history[0])[:red_pegs]
    white_pegs = board.printable_history(board.history[0])[:white_pegs]

    expect(guess).to eq("green, blue, purple, green")
    expect(red_pegs).to eq("0")
    expect(white_pegs).to eq("3")
  end

  it "knows game is over if player runs out of the 8 possible guesses" do
    8.times {board.keep_track_of_results([[:guess], [:feedback]])}

    expect(board.game_over?).to eq(true)
  end

  it "knows game is over when feedback returns 4 white pegs" do
    result = set_up_result(["green", "blue", "purple", "yellow"], 4, 0)
    board.keep_track_of_results(result)

    expect(board.game_over?).to eq(true)
  end

  it "returns :lost if 8 chances to guess ran out" do
    8.times {board.keep_track_of_results([[:guess], [:feedback]])}

    expect(board.verdict).to eq(:lost)
  end

  it "returns :won if codebreaker guesses all 4 colours correctly" do
    result = set_up_result(["green", "blue", "purple", "yellow"], 4, 0)
    board.keep_track_of_results(result)

    expect(board.verdict).to eq(:won)
  end

end
