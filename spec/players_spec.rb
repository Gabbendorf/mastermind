require 'players'
require 'ui'

RSpec.describe Players do

  let(:input) {StringIO.new("Gabriella\n")}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
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

    expect{players.codebreaker(input)}.to raise_error("I didn't understand :(")
  end

  it "creates computer codebreaker" do
    input = "c"

    codebreaker = players.codebreaker(input)

    expect(codebreaker.name).to eq("computer-codebreaker")
  end

  it "creates human player codebreaker" do
    input = "h"

    codebreaker = players.codebreaker(input)

    expect(codebreaker.name).to eq("Gabriella")
  end

end
