class Board

  attr_reader :colour_pattern, :guesses, :all_feeback

  def initialize(rows)
    @rows = rows
    @colour_pattern = []
    @guesses = []
    @all_feeback = []
  end

  def register_colour_pattern(colour)
    @colour_pattern.push(colour)
  end

  def register_guess(guess)
    @guesses.push(guess)
  end

  def register_feedback(feedback)
    @all_feeback.push(feedback)
  end

  def game_over?
    @guesses.size == @rows || @all_feeback.last == [:red, :red, :red, :red]
  end

end
