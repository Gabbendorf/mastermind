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
    {:guess => result.guess.colours.map {|peg_colour| peg_colour.colour}.join(", "),
     :red_pegs => result.feedback.red_pegs.to_s,
     :white_pegs => result.feedback.white_pegs.to_s
    }
  end

  def game_over?
    no_more_guesses? || four_red_pegs?
  end

  def verdict
    if no_more_guesses?
      :codemaker_wins
    elsif four_red_pegs?
      :codebreaker_wins
    end
  end

  private

  def no_more_guesses?
    @history.size == @rows
  end

  def four_red_pegs?
    red_pegs = @history.last.feedback.red_pegs
    red_pegs == 4
  end

end
