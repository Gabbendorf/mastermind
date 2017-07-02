require_relative 'colour_list'
require_relative 'pattern'
require_relative 'peg_colour'

class Computer

  attr_reader :type

  def initialize(type, pattern_size)
    @type = type
    @pattern_size = pattern_size
    @list = ColourList.new
  end

  def create_code_pattern(ui)
    colours = []
    @pattern_size.times {colours.push(PegColour.new(@list.available_colours.sample))}
    ui.confirm_computer_chose_pattern
    Pattern.new(colours)
  end

  def make_guess
    guess = []
    @pattern_size.times {guess.push(PegColour.new(@list.available_colours.sample))}
    Pattern.new(guess)
  end

end
