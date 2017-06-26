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

  def printable_history(result)
    {:guess => result.guess.colours.join(", "),
     :red_pegs => result.feedback.red_pegs.to_s,
     :white_pegs => result.feedback.white_pegs.to_s
    }
  end

  def game_over?
    no_more_guesses? || all_red_pegs?
  end

  private

  def no_more_guesses?
    @history.size == @rows
  end

  def all_red_pegs?
    red_pegs = @history.last[1][0]
    red_pegs == 4
  end

end
