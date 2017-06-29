require 'ui'
require 'pattern'
require 'colour_list'

class HumanPlayer

  attr_reader :name

  def initialize(name, ui, pattern_size)
    @name = name
    @ui = ui
    @pattern_size = pattern_size
  end

  def create_code_pattern
    peg_colours = []
    @pattern_size.times {peg_colours.push(@ui.choose_code_pattern_colour)}
    Pattern.new(peg_colours)
  end

  def make_guess
    guess = []
    @pattern_size.times {guess.push(@ui.make_guess(@name))}
    Pattern.new(guess)
  end

end
