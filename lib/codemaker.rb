require_relative 'colour_list'
require_relative 'pattern'
require_relative 'peg_colour'

class Codemaker

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

end
