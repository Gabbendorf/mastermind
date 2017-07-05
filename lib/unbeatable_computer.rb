require 'set'
require_relative 'peg_colour'
require_relative 'pattern'
require_relative 'colour_list'

class UnbeatableComputer

  attr_reader :possible_patterns

  def initialize(pattern_size, board)
    @pattern_size = pattern_size
    @board = board
    @possible_patterns = Set.new.to_a
    @colour_list = ColourList.new
    @list_for_first_guess = ["green", "pink", "yellow", "purple", "blue", "orange"]
  end

  def make_guess
    if @board.history.size == 0
      random_first_guess
    end
  end

  def generate_all_possible_patterns
    while !demonstrated_possible_patterns_generated?
      random_pattern = []
      @pattern_size.times {random_pattern.push(@colour_list.available_colours.sample)}
      @possible_patterns.push(random_pattern)
      random_pattern = []
    end
  end

  private

  def demonstrated_possible_patterns_generated?
    @possible_patterns.size == 1296
  end

  def random_first_guess
    two_colours = two_same_colours
    first_guess = [two_colours[0], two_colours[0], two_colours[1], two_colours[1]]
    Pattern.new(first_guess.map {|colour| PegColour.new(colour)})
  end

  def two_same_colours
    two_colours = []
    first_colour = @list_for_first_guess.sample
    two_colours.push(first_colour)
    @list_for_first_guess.delete(first_colour)
    second_colour = @list_for_first_guess.sample
    two_colours.push(second_colour)
    two_colours
  end

end
