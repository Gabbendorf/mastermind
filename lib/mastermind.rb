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
    pattern = code_pattern
    board = Board.new(8, pattern)
    play(board, pattern)
  end

  private

  def code_pattern
    @ui.print_logo
    codemaker = @players.codemaker(@ui.choose_codemaker)
    pattern = codemaker.create_code_pattern
    pattern
  end

  def play(board, pattern)
    codebreaker = @players.codebreaker(@ui.choose_codebreaker)
    guess = codebreaker.make_guess
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
