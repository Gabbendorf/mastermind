require 'spec_helper'
require_relative '../lib/mastermind'
require_relative '../lib/codemaker'
require_relative '../lib/codebreaker'
require_relative '../lib/ui'
require_relative '../lib/peg_colour'
require_relative '../lib/pattern'

RSpec.describe Mastermind do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:codemaker) {Codemaker.new("computer", 4)}
  let(:codebreaker) {Codebreaker.new("Gabriella", ui, 4)}
  let(:mastermind) {Mastermind.new(ui, codemaker, codebreaker)}

  it "runs a new game with computer as codemaker and human player as codebreaker" do
    input = StringIO.new("green\npink\nyellow\ngrey\npurple\norange\nblue\npurple\nyellow\n")
    ui = Ui.new(input, output)
    codemaker = FakeCodemaker.new("computer", 4)
    codebreaker = Codebreaker.new("Gabriella", ui, 4)
    mastermind = Mastermind.new(ui, codemaker, codebreaker)

    mastermind.run_game

    expect(output.string).to include("Congratulations Gabriella: YOU WON!")
  end

end

class FakeCodemaker

  def initialize(type, pattern_size)
    @type = type
    @pattern_size = pattern_size
    @available_colours = ["green", "pink", "yellow", "purple", "blue", "orange"]
  end

  def create_code_pattern
    colours = []
    @pattern_size.times {colours.push(PegColour.new(@available_colours.pop))}
    Pattern.new(colours)
  end

end
