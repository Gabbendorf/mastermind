require_relative 'peg_colour'
require_relative 'pattern'

class UnbeatableComputer

  def initialize(colour_list)
    @colour_list = colour_list
  end

  COLOURS = ["green", "pink", "yellow", "purple", "blue", "orange"]

  def make_guess
    first_guess
  end

  private

  def first_guess
    two_colours = two_same_colours
    first_guess = [two_colours[0], two_colours[0], two_colours[1], two_colours[1]]
    Pattern.new(first_guess.map {|colour| PegColour.new(colour)})
  end

  def two_same_colours
    two_colours = []
    first_colour = COLOURS.sample
    two_colours.push(first_colour)
    COLOURS.delete(first_colour)
    second_colour = COLOURS.sample
    two_colours.push(second_colour)
    two_colours
  end

end
