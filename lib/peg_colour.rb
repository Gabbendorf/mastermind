class PegColour

  attr_reader :colours, :colour

  def initialize(colour_string)
    @colours = ["green", "pink", "yellow", "purple", "blue", "orange"]
    if !@colours.include?(colour_string)
      raise("Invalid colour")
    end
    @colour = colour_string
  end

  def prepare_list
    @colours.join(", ")
  end

end
