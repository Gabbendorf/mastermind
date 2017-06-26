require_relative 'colour_list'

class PegColour

  attr_reader :colour

  def initialize(colour_string)
    if !ColourList.new.available_colours.include?(colour_string)
      raise("Invalid colour")
    end
    @colour = colour_string
  end

end
