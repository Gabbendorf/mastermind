require_relative 'feedback'

class Pattern

  attr_reader :colours

  def initialize(colours)
    @colours = colours
  end

  def compare(guess)
    rest_of_code_pattern = []
    rest_of_guess = []
    red_pegs = 0
    guess_colours(guess).each_index do |index|
      identical?(guess_colours(guess), index) ?
        red_pegs += 1 : separate(rest_of_code_pattern, rest_of_guess, guess_colours(guess), index)
    end
    white_pegs = white_pegs_count(rest_of_code_pattern, rest_of_guess)
    Feedback.new(red_pegs, white_pegs)
  end

  def code_pattern_colours
    @colours.map {|peg_colour| peg_colour.colour}
  end

  private

  def identical?(guess_colours, index)
    guess_colours[index] == code_pattern_colours[index]
  end

  def separate(rest_of_code_pattern, rest_of_guess, guess_colours, index)
    rest_of_code_pattern.push(code_pattern_colours[index])
    rest_of_guess.push(guess_colours[index])
  end

  def white_pegs_count(rest_of_code_pattern, rest_of_guess)
    (rest_of_code_pattern & rest_of_guess).size
  end

  def guess_colours(guess)
    guess.colours.map {|peg_colour| peg_colour.colour}
  end

end
