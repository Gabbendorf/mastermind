require_relative 'peg_colour'
require_relative 'pattern'

class Codemaker

  def initialize(type, peg_colour, pattern_size)
    @type = type
    @peg_colour = peg_colour
    @pattern_size = pattern_size
  end

  def create_code_pattern
    colours = []
    @pattern_size.times {colours.push(@peg_colour.colours.sample)}
    Pattern.new(colours)
  end

end
