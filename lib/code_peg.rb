class CodePeg

  attr_reader :colours

  def initialize
    @colours = ["green", "pink", "yellow", "purple", "blue", "orange"]
  end

  def valid_colour(colour_chosen)
    !@colours.include?(colour_chosen) ? :repeat_choice : colour_chosen
  end

end
