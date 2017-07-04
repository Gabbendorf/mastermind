require_relative 'ui'
require_relative 'computer'
require_relative 'human_player'

class Players

  def initialize(ui)
    @ui = ui
  end

  def codemaker(input)
    if input == "c"
      Computer.new("computer-codemaker", 4)
    elsif input == "h"
      HumanPlayer.new(@ui.ask_human_player_name, @ui, 4)
    else
      raise("I didn't understand :(")
    end
  end

  def codebreaker(input)
    if input == "c"
      Computer.new("computer-codebreaker", 4)
    elsif input == "h"
      HumanPlayer.new(@ui.ask_human_player_name, @ui, 4)
    else
      raise("I didn't understand :(")
    end
  end

end
