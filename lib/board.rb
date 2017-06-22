class Board

  attr_reader :colour_pattern

  def initialize(rows)
    @rows = rows
    @colour_pattern = []
    @guesses = []
  end

  def register_colour_pattern(colour)
    @colour_pattern.push(colour)
  end

  def register_guess(guess)
    @guesses.push(guess)
  end

end
