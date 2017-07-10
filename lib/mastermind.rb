require_relative 'ui'
require_relative 'computer'
require_relative 'human_player'
require_relative 'board'
require_relative 'result'
require_relative 'players'

class Mastermind

  def initialize(ui, players)
    @ui = ui
    @players = players
  end

  def run_game
    @ui.print_logo
    codemaker = @ui.choose_codemaker(@players)
    pattern = codemaker.create_code_pattern(@ui)
    board = Board.new(8, pattern)
    codebreaker = @ui.choose_codebreaker(@players, board)
    play(pattern, board, codemaker, codebreaker)
  end

  private

  def play(pattern, board, codemaker, codebreaker)
    guess = codebreaker.make_guess
    feedback = pattern.compare(guess)
    new_result = Result.new(guess, feedback)
    board.keep_track_of_results(new_result)
    @ui.print_history(board.history, board)
    next_move(board, pattern, codemaker, codebreaker)
  end

  def next_move(board, pattern, codemaker, codebreaker)
    if board.game_over?
      end_of_game(board, codemaker, codebreaker)
    else
      play(pattern, board, codemaker, codebreaker)
    end
  end

  def end_of_game(board, codemaker, codebreaker)
    game_verdict = board.verdict
    game_verdict == :codemaker_wins ? @ui.codemaker_is_winner(codemaker.name) : @ui.codebreaker_is_winner(codebreaker.name)
    answer = @ui.play_again
    answer == "y" ? run_game : @ui.say_goodbye
  end

end
