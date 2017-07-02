class ColourList

  def available_colours
    ["green", "pink", "yellow", "purple", "blue", "orange"]
  end

  def prepare_list
    available_colours.join(", ")
  end

end
