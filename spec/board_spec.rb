require 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/feedback'

RSpec.describe Board do

  code_pattern = ["green", "blue", "purple", "yellow"]
  let(:board) {Board.new(8, code_pattern)}

  it "registers a result containing guess and feedback" do
    guess = ["red", "blue", "yellow", "green"]
    feedback = Feedback.new(1, 2)
    result = [guess, [feedback]]

    board.keep_track_of_results(result)

    expect(board.history).to eq ([[["red", "blue", "yellow", "green"], [feedback]]])
  end

  it "knows when game is over" do
    board.keep_track_of_results([[:guess1], [:feedback]])
    board.keep_track_of_results([[:guess2], [:feedback2]])
    board.keep_track_of_results([[:guess3], [:feedback3]])
    board.keep_track_of_results([[:guess4], [:feedback4]])
    board.keep_track_of_results([[:guess5], [:feedback5]])
    board.keep_track_of_results([[:guess6], [:feedback6]])
    board.keep_track_of_results([[:guess7], [:feedback7]])
    board.keep_track_of_results([[:guess8], [:feedback8]])

    expect(board.game_over?).to eq(true)
  end

  it "knows when game is over" do
    board.keep_track_of_results([["green", "blue", "purple", "yellow"], [4, 0]])

    expect(board.game_over?).to eq(true)
  end

end
