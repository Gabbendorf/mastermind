require_relative 'ui'
require_relative 'pattern'
require_relative 'colour_list'

class Codebreaker

  attr_reader :name

  def initialize(name, ui, pattern_size)
    @name = name
    @ui = ui
    @pattern_size = pattern_size
  end

  def make_guess
    guess = []
    @pattern_size.times {guess.push(@ui.make_guess(@name))}
    Pattern.new(guess)
  end

end
