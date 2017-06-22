class Feedback

  def give_feedback(pattern, guess)
    feedback = []
    same_colour(pattern, guess).size.times {feedback.push(:same_colour)}
    same_position(pattern, guess).size.times {feedback.push(:same_position)}
    feedback
  end

  private

  def same_colour(pattern, guess)
    same_colours = []
    index = 0
    guess.each do |colour|
      if pattern.include?(colour) && colour != pattern[index]
        same_colours.push(colour)
      end
      index += 1
    end
    same_colours
  end

  def same_position(pattern, guess)
    same_positions = []
    index = 0
    guess.each do |colour|
      if colour == pattern[index]
        same_positions.push(colour)
      end
      index += 1
    end
    same_positions
  end

end
