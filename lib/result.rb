class Result

  attr_reader :guess, :feedback

  def initialize(guess, feedback)
    @guess = guess
    @feedback = feedback
  end

end
