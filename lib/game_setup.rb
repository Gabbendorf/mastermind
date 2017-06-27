require 'codemaker'
require 'board'

class GameSetup

  attr_reader :rows

  def initialize(codemaker, rows)
    @codemaker = codemaker
    @rows = rows
  end

  def create_board
    pattern = @codemaker.create_code_pattern
    Board.new(@rows, pattern)
  end

end
