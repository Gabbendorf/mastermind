require 'spec_helper'
require_relative '../lib/colour_list'

RSpec.describe ColourList do

  let(:colour_list) {ColourList.new}

  it "has a list of 6 available colours" do
    colours_count = colour_list.available_colours.size

    expect(colours_count).to eq(6)
  end

  it "prepares a list of strings to be printed for player" do
    expect(colour_list.prepare_list).to eq("green, pink, yellow, purple, blue, orange")
  end

end
