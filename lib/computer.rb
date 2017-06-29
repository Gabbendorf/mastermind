require 'colour_list'
require 'pattern'
require 'peg_colour'

class Computer

  def initialize(type, pattern_size)
    @type = type
    @pattern_size = pattern_size
    @list = ColourList.new
  end

  def create_code_pattern
    colours = []
    @pattern_size.times {colours.push(PegColour.new(@list.available_colours.sample))}
    Pattern.new(colours)
  end

  def make_guess
    guess = []
    @pattern_size.times {guess.push(PegColour.new(@list.available_colours.sample))}
    Pattern.new(guess)
  end

end
