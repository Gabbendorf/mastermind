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
    @temporary_pattern = []
  end

  LIST_FOR_FIRST_GUESS = ["green", "pink", "yellow", "purple", "blue", "orange"]

  def make_guess
    if @board.history.size == 0
      make_first_guess
    # else
    #   generate_all_possible_patterns
    #   make_next_guess
    end
  end

  # Hypotetical method for next guess
  # def make_next_guess
  #   delete_incompatible_patterns(@possible_patterns, @temporary_pattern)
  #   @temporary_pattern = @possible_patterns.sample
  # end

  def generate_all_possible_patterns
    while !demonstrated_possible_patterns_generated?
      random_colours = []
      @pattern_size.times {random_colours.push(PegColour.new(@colour_list.available_colours.sample))}
      @possible_patterns.push(Pattern.new(random_colours))
    end
  end

  def delete_incompatible_patterns(possible_patterns, temporary_pattern)
    possible_patterns.each do |pattern|
      random_pattern_feedback = temporary_pattern.compare(pattern)
      random_pattern_feedback_pegs = red_pegs_and_white_pegs(random_pattern_feedback)
      if feedback_pegs_for_first_guess != random_pattern_feedback_pegs
        possible_patterns.delete(pattern)
      end
    end
  end

  def feedback_pegs_for_first_guess
    firt_guess_result = @board.history[0]
    feedback = firt_guess_result.feedback
    red_pegs_and_white_pegs(feedback)
  end

  private

  def red_pegs_and_white_pegs(feedback)
    red_pegs = feedback.red_pegs
    white_pegs = feedback.white_pegs
    [red_pegs, white_pegs]
  end

  def demonstrated_possible_patterns_generated?
    @possible_patterns.size == 1296
  end

  def make_first_guess
    two_colours = two_random_colours
    first_colour = two_colours[0]
    second_colour = two_colours[1]
    first_guess = [first_colour, first_colour, second_colour, second_colour]
    first_guess = Pattern.new(first_guess.map {|colour| PegColour.new(colour)})
    @temporary_pattern = first_guess
    first_guess
  end

  def two_random_colours
    first_colour = LIST_FOR_FIRST_GUESS.sample
    LIST_FOR_FIRST_GUESS.delete(first_colour)
    second_colour = LIST_FOR_FIRST_GUESS.sample
    [first_colour, second_colour]
  end

end
