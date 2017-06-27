require_relative 'ui'
require_relative 'codemaker'
require_relative 'codebreaker'
require_relative 'board'
require_relative 'result'

class Mastermind

  def initialize(ui, codemaker, codebreaker)
    @ui = ui
    @codemaker = codemaker
    @codebreaker = codebreaker
  end

  def start_game
    set_up_game
    end_of_game
  end

  private

  def code_pattern
    @ui.print_logo
    pattern = @codemaker.create_code_pattern
    @ui.confirm_computer_chose_pattern
    pattern
  end

  def set_up_game
    pattern = code_pattern
    board = Board.new(8, pattern)
    @ui.make_guess(@codebreaker.name)
    guess = @codebreaker.make_guess
    feedback = pattern.compare(guess.colours)
    new_result = Result.new(guess, feedback)
    board.keep_track_of_results(new_result)
    @ui.print_history(board.history, board)
    if board.game_over?
      end_of_game(board)
    else
      set_up_game
    end
  end

  def end_of_game(board)
    game_verdict = board.verdict
    game_verdict == :lost ? @ui.declare_loser : @ui.declare_winner
  end

end

ui = Ui.new($stdin, $stdout)
codemaker = Codemaker.new("computer", 4)
codebreaker = Codebreaker.new("Gabriella", ui, 4)
mastermind = Mastermind.new(ui, codemaker, codebreaker)

mastermind.start_game
