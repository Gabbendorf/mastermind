class Board

  attr_reader :code_pattern, :history, :all_feeback

  def initialize(rows, code_pattern)
    @rows = rows
    @code_pattern = code_pattern
    @history = []
    @all_feeback = []
  end

  def keep_track_of_results(result)
    @history.push(result)
  end

  def game_over?
    no_more_guesses? || all_red_pegs?
  end

  private

  def no_more_guesses?
    @history.size == @rows
  end

  def all_red_pegs?
    @history.last[1][0] == 4
  end

end
