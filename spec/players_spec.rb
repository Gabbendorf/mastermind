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
    player_selection = "robot"

    expect{players.codemaker(player_selection)}.to raise_error("I didn't understand :(")
  end

  it "creates computer codemaker" do
    player_selection = "c"

    codemaker = players.codemaker(player_selection)

    expect(codemaker.name).to eq("computer-codemaker")
  end

  it "creates human player codemaker" do
    player_selection = "h"

    codemaker = players.codemaker(player_selection)

    expect(codemaker.name).to eq("Gabriella")
  end

  it "raises error if entered input for codebreaker is invalid" do
    player_selection = "robot"

    expect{players.codebreaker(player_selection, board)}.to raise_error("I didn't understand :(")
  end

  it "creates computer codebreaker" do
    player_selection = "c"

    codebreaker = players.codebreaker(player_selection, board)

    expect(codebreaker.name).to eq("computer-codebreaker")
  end

  it "creates human player codebreaker" do
    player_selection = "h"

    codebreaker = players.codebreaker(player_selection, board)

    expect(codebreaker.name).to eq("Gabriella")
  end

  it "creates smart computer codebreaker" do
    player_selection = "s"

    codebreaker = players.codebreaker(player_selection, board)

    expect(codebreaker.name).to eq("smart computer")
  end

end
