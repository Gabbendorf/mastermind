require 'spec_helper'
require_relative '../lib/code_peg'

RSpec.describe CodePeg do

  let(:code_peg) {CodePeg.new}

  it "comes in 6 colours" do
    expect(code_peg.colours.size).to eq(6)
  end

  it "returns colour chosen if it's valid" do
    colour = "green"

    expect(code_peg.valid_colour(colour)).to eq(colour)
  end

  it "returns :repeat_choice if colour given is not valid" do
    colour = "grey"

    expect(code_peg.valid_colour(colour)).to eq(:repeat_choice)
  end

end
