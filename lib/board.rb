class Board

  attr_reader :colour_pattern

  def initialize(rows)
    @rows = rows
    @colour_pattern = []
  end

  def register_colour_pattern(colour)
    @colour_pattern.push(colour)
  end

end
