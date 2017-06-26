require 'spec_helper'
require_relative '../lib/codemaker'
require_relative '../lib/peg_colour'

RSpec.describe Codemaker do

  let(:peg_colour) {PegColour.new("green")}
  let(:codemaker) {Codemaker.new("computer", peg_colour, 4)}

  it "creates a code pattern by choosing 4 numbers randomly" do
    available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]

    pattern = codemaker.create_code_pattern

    colour1 = pattern.colours[0]
    colour2 = pattern.colours[1]
    colour3 = pattern.colours[2]
    colour4 = pattern.colours[3]

    expect(available_colours).to include(colour1, colour2, colour3, colour4)
  end

end
