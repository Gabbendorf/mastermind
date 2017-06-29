require 'spec_helper'
require_relative '../lib/codemaker'

RSpec.describe Codemaker do

  let(:codemaker) {Codemaker.new("computer", 4)}

  it "creates a code pattern by choosing 4 numbers randomly" do
    available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]

    pattern = codemaker.create_code_pattern

    colour1 = pattern.colours[0].colour
    colour2 = pattern.colours[1].colour
    colour3 = pattern.colours[2].colour
    colour4 = pattern.colours[3].colour

    expect(available_colours).to include(colour1, colour2, colour3, colour4)
  end

end
