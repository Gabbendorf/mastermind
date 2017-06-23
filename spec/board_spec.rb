require 'spec_helper'
require_relative '../lib/board'

RSpec.describe Board do

  let(:board) {Board.new(8)}

  it "registers each colour given by codemaker" do
    colour_choices = {1 => "green",
                      2 => "blue",
                      3 => "purple",
                      4 => "yellow"
                      }

    colour_choices.each {|key, value| board.register_colour_pattern(value)}

    expect(board.colour_pattern).to eq(["green", "blue", "purple", "yellow"])
  end

  it "registers a guess" do
    guess = ["red", "blue", "yellow", "green"]
    guess2 = ["red", "purple", "yellow", "orange"]

    board.register_guess(guess)
    board.register_guess(guess2)

    expect(board.guesses).to eq ([["red", "blue", "yellow", "green"], ["red", "purple", "yellow", "orange"]])
  end

end
