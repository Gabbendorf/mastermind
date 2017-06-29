require 'spec_helper'
require_relative '../lib/pattern'
require_relative '../lib/feedback'
require_relative '../lib/peg_colour'

RSpec.describe Pattern do

  def set_up_guess(colour_strings)
    peg_colours = colour_strings.map {|colour| PegColour.new(colour)}
    Pattern.new(peg_colours)
  end

  def peg_colours(colour_strings)
    colour_strings.map {|colour| PegColour.new(colour)}
  end

  let(:pattern) {Pattern.new(peg_colours(["yellow", "blue", "purple", "green"]))}

  it "returns feedback with 0 red pegs and 0 white peg for no common colours" do
    guess = set_up_guess(["orange", "orange", "pink", "pink"])

    feedback = pattern.compare(guess)

    expect(feedback).to have_attributes(:red_pegs => 0, :white_pegs => 0)
  end

  describe "compares patterns with colours in common in different positions" do
    it "returns feedback with 0 red pegs and 1 white peg" do
      guess = set_up_guess(["orange", "orange", "yellow", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 0, :white_pegs => 1)
    end

    it "returns feedback with 0 red pegs and 2 white pegs" do
      guess = set_up_guess(["orange", "green", "yellow", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 0, :white_pegs => 2)
    end

    it "returns feedback with 0 red pegs and 3 white pegs" do
      guess = set_up_guess(["purple", "green", "yellow", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 0, :white_pegs => 3)
    end

    it "returns feedback with 0 red pegs and 4 white pegs" do
      guess = set_up_guess(["purple", "green", "yellow", "blue"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 0, :white_pegs => 4)
    end
  end

  describe "compares patterns with colours in common in same positions" do
    it "returns feedback with 1 red peg and 0 white pegs for 1 common position" do
      guess = set_up_guess(["orange", "orange", "purple", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 1, :white_pegs => 0)
    end

    it "returns feedback with 2 red pegs and 0 white pegs" do
      guess = set_up_guess(["yellow", "orange", "purple", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 2, :white_pegs => 0)
    end

    it "returns feedback with 3 red pegs and 0 white pegs" do
      guess = set_up_guess(["yellow", "blue", "purple", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 3, :white_pegs => 0)
    end

    it "returns feedback with 4 red pegs and 0 white pegs" do
      guess = set_up_guess(["yellow", "blue", "purple", "green"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 4, :white_pegs => 0)
    end
  end

  describe "compares patterns with colours in common both in same and different positions" do
    it "returns feedback with 1 red peg and 1 white peg" do
      guess = set_up_guess(["yellow", "orange", "green", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 1, :white_pegs => 1)
    end

    it "returns feedback with 1 red peg and 2 white peg" do
      guess = set_up_guess(["yellow", "orange", "green", "blue"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 1, :white_pegs => 2)
    end
  end

  describe "compares pattern with guess with duplicated colour present only once in pattern" do
    it "returns feedback with 1 red peg only for colour yellow in same position" do
      guess = set_up_guess(["yellow", "orange", "yellow", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 1, :white_pegs => 0)
    end

    it "returns feedback with only 1 white peg for repeated yellow in different positions" do
      guess = set_up_guess(["orange", "yellow", "yellow", "pink"])

      feedback = pattern.compare(guess)

      expect(feedback).to have_attributes(:red_pegs => 0, :white_pegs => 1)
    end
  end

end
