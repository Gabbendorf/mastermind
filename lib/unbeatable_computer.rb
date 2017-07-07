require 'set'
require_relative 'peg_colour'
require_relative 'pattern'
require_relative 'colour_list'

class UnbeatableComputer

  attr_reader :name, :all_possible_patterns

  def initialize(name, pattern_size, board)
    @name = name
    @pattern_size = pattern_size
    @board = board
    @all_possible_patterns = []
    @colour_list = ColourList.new
    @temporary_pattern = []
  end

  LIST_FOR_FIRST_GUESS = ["green", "pink", "yellow", "purple", "blue", "orange"]

  def make_guess
    if empty_board_history?
      generate_all_possible_patterns
      make_first_guess
    else
      make_next_guess
    end
  end

  #TODO: re-implement, takes a lot to run (wrong implementation) - started alternative below
  def generate_all_possible_patterns
    while !demonstrated_possible_patterns_generated?
      random_colours = []
      @pattern_size.times {random_colours.push(PegColour.new(@colour_list.available_colours.sample))}
      @all_possible_patterns.push(Pattern.new(random_colours))
      @all_possible_patterns.uniq
    end
  end

  # def generate_all_possible_patterns
  #   while !demonstrated_possible_patterns_generated?
  #     LIST_FOR_FIRST_GUESS.each do |colour|
  #
  #     end
  #   end
  # end

  def feedback_pegs_for_guess(guess)
    feedback = @board.show_guesses_and_feedback[guess]
    red_pegs_and_white_pegs(feedback)
  end

  private

  def make_first_guess
    colour_strings = first_guess
    colours = []
    colour_strings.each {|colour_string| colours.push(PegColour.new(colour_string))}
    guess = Pattern.new(colours)
    update_possible_patterns_and_temporary_pattern(guess)
    guess
  end

  def make_next_guess
    delete_incompatible_patterns(@all_possible_patterns, @temporary_pattern)
    guess = @all_possible_patterns.sample
    update_possible_patterns_and_temporary_pattern(guess)
    guess
  end

  def delete_incompatible_patterns(all_possible_patterns, temporary_pattern)
    all_possible_patterns.each do |pattern|
      pattern_feedback = temporary_pattern.compare(pattern)
      pattern_feedback_pegs = red_pegs_and_white_pegs(pattern_feedback)
      if feedback_pegs_for_guess(temporary_pattern) != pattern_feedback_pegs
        all_possible_patterns.delete(pattern)
      end
    end
  end

  def empty_board_history?
    @board.history.size == 0
  end

  def red_pegs_and_white_pegs(feedback)
    red_pegs = feedback.red_pegs
    white_pegs = feedback.white_pegs
    [red_pegs, white_pegs]
  end

  def demonstrated_possible_patterns_generated?
    @all_possible_patterns.size == 1296
  end

  def first_guess
    two_colours = two_random_colours
    first_colour = two_colours[0]
    second_colour = two_colours[1]
    [first_colour, first_colour, second_colour, second_colour]
  end

  def two_random_colours
    first_colour = LIST_FOR_FIRST_GUESS.sample
    LIST_FOR_FIRST_GUESS.delete(first_colour)
    second_colour = LIST_FOR_FIRST_GUESS.sample
    [first_colour, second_colour]
  end

  def update_possible_patterns_and_temporary_pattern(guess)
    @all_possible_patterns.delete(guess)
    @temporary_pattern = guess
  end

end
