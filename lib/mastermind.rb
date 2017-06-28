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

  def run_game
    pattern = code_pattern
    board = Board.new(8, pattern)
    play(board, pattern)
  end

  private

  def code_pattern
    @ui.print_logo
    pattern = @codemaker.create_code_pattern
    @ui.confirm_computer_chose_pattern
    pattern
  end

  def play(board, pattern)
    @ui.make_guess(@codebreaker.name)
    guess = @codebreaker.make_guess
    feedback = pattern.compare(guess.colours)
    new_result = Result.new(guess, feedback)
    board.keep_track_of_results(new_result)
    @ui.print_history(board.history, board)
    if board.game_over?
      end_of_game(board)
    else
      play(board, pattern)
    end
  end

  def end_of_game(board)
    game_verdict = board.verdict
    game_verdict == :lost ? @ui.declare_loser : @ui.declare_winner
  end

end
