require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/colour_list'

RSpec.describe UnbeatableComputer do

  let(:colour_list) {ColourList.new}
  let(:unbeatable_computer) {UnbeatableComputer.new(colour_list)}

  it "gives 2 choices of same colour and 2 of another colour as 1st guess" do
    first_guess = unbeatable_computer.make_guess

    first_colour = first_guess.colours[0].colour
    second_colour = first_guess.colours[2].colour

    first_guess_colours = first_guess.colours.map(&:colour)
    expect(first_guess_colours).to eq([first_colour, first_colour, second_colour, second_colour])
  end

end
