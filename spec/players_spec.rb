require 'spec_helper'
require_relative '../lib/players'
require_relative '../lib/ui'
require_relative '../lib/pattern'
require_relative '../lib/board'

RSpec.describe Players do

  let(:input) {StringIO.new("Gabriella\n")}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:pattern) {double}
  let(:board) {Board.new(8, pattern)}
  let(:players) {Players.new(ui)}

  it "raises error if entered input for codemaker is invalid" do
    input = "robot"

    expect{players.codemaker(input)}.to raise_error("I didn't understand :(")
  end

  it "creates computer codemaker" do
    input = "c"

    codemaker = players.codemaker(input)

    expect(codemaker.name).to eq("computer-codemaker")
  end

  it "creates human player codemaker" do
    input = "h"

    codemaker = players.codemaker(input)

    expect(codemaker.name).to eq("Gabriella")
  end

  it "raises error if entered input for codebreaker is invalid" do
    input = "robot"

    expect{players.codebreaker(input, board)}.to raise_error("I didn't understand :(")
  end

  it "creates computer codebreaker" do
    input = "c"

    codebreaker = players.codebreaker(input, board)

    expect(codebreaker.name).to eq("computer-codebreaker")
  end

  it "creates human player codebreaker" do
    input = "h"

    codebreaker = players.codebreaker(input, board)

    expect(codebreaker.name).to eq("Gabriella")
  end

  it "creates smart computer codebreaker" do
    input = "s"

    codebreaker = players.codebreaker(input, board)

    expect(codebreaker.name).to eq("smart computer")
  end

end
