require 'spec_helper'
require_relative '../lib/peg_colour'

RSpec.describe PegColour do

  let(:peg_colour) {PegColour.new("green")}

  it "raises an error on instantiation if players enters invalid colour" do
    colour = "grey"

    expect{PegColour.new(colour)}.to raise_error("Invalid colour")
  end

  it "prepares a list of strings to be printed for player" do
    expect(peg_colour.prepare_list).to eq("green, pink, yellow, purple, blue, orange")
  end

end
