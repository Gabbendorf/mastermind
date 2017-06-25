require 'feedback'

class Pattern

  attr_reader :colours

  def initialize(colours)
    @colours = colours
  end

  def compare(guess)
    rest_of_code_pattern = []
    rest_of_guess = []
    red_pegs = 0
    guess.each_index do |index|
      identical?(guess, index) ?
        red_pegs += 1 : separate(rest_of_code_pattern, rest_of_guess, guess, index)
    end
    white_pegs = white_pegs_count(rest_of_code_pattern, rest_of_guess)
    Feedback.new(red_pegs, white_pegs)
  end

  private

  def identical?(guess, index)
    guess[index] == @colours[index]
  end

  def separate(rest_of_code_pattern, rest_of_guess, guess, index)
    rest_of_code_pattern.push(@colours[index])
    rest_of_guess.push(guess[index])
  end

  def white_pegs_count(rest_of_code_pattern, rest_of_guess)
    (rest_of_code_pattern & rest_of_guess).size
  end

end
