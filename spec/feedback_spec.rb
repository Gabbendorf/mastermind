require 'spec_helper'
require_relative '../lib/feedback'

RSpec.describe Feedback do

  let(:feedback) {Feedback.new}

  it "returns empty array if guess and pattern are different" do
    pattern = ["yellow", "yellow", "green", "purple"]
    guess = ["blue", "blue", "red", "orange"]

    expect(feedback.give_feedback(pattern, guess)).to eq([])
  end

  it "returns 1 :same_colour if guess and pattern have 1 same colour in different position" do
    pattern = ["yellow", "yellow", "green", "purple"]
    guess = ["green", "blue", "red", "orange"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_colour])
  end

  it "returns 2 :same_colour if guess and pattern have 2 same colours in different positions" do
    pattern = ["red", "yellow", "green", "purple"]
    guess = ["green", "blue", "red", "orange"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_colour, :same_colour])
  end

  it "returns 3 :same_colour if guess and pattern have 3 same colours in different positions" do
    pattern = ["red", "yellow", "green", "purple"]
    guess = ["green", "purple", "red", "orange"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_colour, :same_colour, :same_colour])
  end

  it "returns 4 :same_colour if guess and pattern have 4 same colours in different positions" do
    pattern = ["red", "yellow", "green", "purple"]
    guess = ["green", "purple", "red", "yellow"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_colour, :same_colour, :same_colour, :same_colour])
  end

  it "returns 1 :same_position if guess and pattern have 1 same colour in same position" do
    pattern = ["yellow", "yellow", "green", "purple"]
    guess = ["yellow", "blue", "red", "orange"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_position])
  end

  it "returns 2 :same_position if guess and pattern have 2 same colour in same position" do
    pattern = ["yellow", "yellow", "green", "purple"]
    guess = ["yellow", "yellow", "red", "orange"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_position, :same_position])
  end

  it "returns 3 :same_position if guess and pattern have 3 same colours in same position" do
    pattern = ["yellow", "blue", "green", "purple"]
    guess = ["yellow", "blue", "green", "orange"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_position, :same_position, :same_position])
  end

  it "returns 4 :same_position if guess and pattern have 4 same colours in same position" do
    pattern = ["yellow", "blue", "green", "purple"]
    guess = ["yellow", "blue", "green", "purple"]

    expect(feedback.give_feedback(pattern, guess)).to eq([:same_position, :same_position, :same_position, :same_position])
  end

end
