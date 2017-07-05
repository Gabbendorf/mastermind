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
  end

  LIST_FOR_FIRST_GUESS = ["green", "pink", "yellow", "purple", "blue", "orange"]

  def make_guess
    if @board.history.size == 0
      first_guess
    end
  end

  def generate_all_possible_patterns
    while !demonstrated_possible_patterns_generated?
      random_colours = []
      @pattern_size.times {random_colours.push(PegColour.new(@colour_list.available_colours.sample))}
      @possible_patterns.push(Pattern.new(random_colours))
    end
  end

  private

  def demonstrated_possible_patterns_generated?
    @possible_patterns.size == 1296
  end

  def first_guess
    two_colours = two_random_colours
    first_colour = two_colours[0]
    second_colour = two_colours[1]
    first_guess = [first_colour, first_colour, second_colour, second_colour]
    Pattern.new(first_guess.map {|colour| PegColour.new(colour)})
  end

  def two_random_colours
    first_colour = LIST_FOR_FIRST_GUESS.sample
    LIST_FOR_FIRST_GUESS.delete(first_colour)
    second_colour = LIST_FOR_FIRST_GUESS.sample
    [first_colour, second_colour]
  end

end
