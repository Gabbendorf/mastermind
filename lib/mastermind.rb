require 'ui'
require 'computer'
require 'human_player'
require 'board'
require 'result'

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
    guess = @codebreaker.make_guess
    feedback = pattern.compare(guess)
    new_result = Result.new(guess, feedback)
    board.keep_track_of_results(new_result)
    @ui.print_history(board.history, board)
    next_move(board, pattern)
  end

  def next_move(board, pattern)
    if board.game_over?
      end_of_game(board)
    else
      play(board, pattern)
    end
  end

  def end_of_game(board)
    game_verdict = board.verdict
    game_verdict == :lost ? @ui.declare_loser(@codebreaker.name) : @ui.declare_winner(@codebreaker.name)
  end

end
