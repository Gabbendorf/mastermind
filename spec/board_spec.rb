require 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/feedback'
require_relative '../lib/pattern'
require_relative '../lib/result'

RSpec.describe Board do

  let(:board) {Board.new(8, ["green", "pink", "green", "blue"])}

  def set_up_result(colours, red, white)
    guess = Pattern.new(colours)
    feedback = Feedback.new(red, white)
    Result.new(guess, feedback)
  end

  it "registers a result containing guess and feedback" do
    result = set_up_result(["red", "blue", "yellow", "green"], 1, 2)

    board.keep_track_of_results(result)

    expect(board.history).to eq ([result])
  end

  it "returns strings in a hash for guess and feedback of each result" do
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
    board.keep_track_of_results([["green", "blue", "purple", "yellow"], [4, 0]])

    expect(board.game_over?).to eq(true)
  end

  it "returns :lost if 8 chances to guess ran out" do
    8.times {board.keep_track_of_results([[:guess], [:feedback]])}

    expect(board.verdict).to eq(:lost)
  end

  it "returns :won if codebreaker guesses all 4 colours correctly" do
    board.keep_track_of_results([["green", "blue", "purple", "yellow"], [4, 0]])

    expect(board.verdict).to eq(:won)
  end

end
