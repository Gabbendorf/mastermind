require 'set'
require_relative 'peg_colour'
require_relative 'pattern'
require_relative 'colour_list'

class UnbeatableComputer

  attr_reader :possible_patterns#, :temporary_pattern

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
  #   generate_all_possible_patterns
      make_first_guess
    # else
    #   make_next_guess
    end
  end

  # Hypotetical method
  # def make_next_guess
  #   feedback = get_feedback_for_temporary_pattern(@temporary_pattern)
  #   delete_incompatible_patterns(feedback)
  #   @temporary_pattern = @possible_patterns.sample
  # end

  def generate_all_possible_patterns
    while !demonstrated_possible_patterns_generated?
      random_colours = []
      @pattern_size.times {random_colours.push(PegColour.new(@colour_list.available_colours.sample))}
      @possible_patterns.push(Pattern.new(random_colours))
    end
  end

  # Hypotetical method
  # def delete_incompatible_patterns(temporary_pattern)
  #   @possible_patterns.each do |pattern|
  #     feedback = @temporary_pattern.compare(pattern)
  #     if feedback_pegs_for(temporary_pattern) != feedback_pegs_for(pattern)
  #       @possible_patterns.delete(pattern)
  #     end
  #   end
  # end

  def feedback_pegs_for(guess)
    @board.history.each do |result|
      if result.guess == guess
        feedback = result.feedback
      end
      return [feedback.red_pegs, feedback.white_pegs]
    end
  end

  private

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
