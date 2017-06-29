require_relative 'ui'
require_relative 'computer'
require_relative 'human_player'

class Players

  def initialize(ui)
    @ui = ui
  end

  def codemaker(input)
    if input == "computer"
      Computer.new("computer", 4)
    elsif input == "human player"
      HumanPlayer.new("Gabriella", @ui, 4)
    end
  end

  def codebreaker(input)
    if input == "computer"
      Computer.new("computer", 4)
    elsif input == "human player"
      HumanPlayer.new("Gabriella", @ui, 4)
    end
  end

end
