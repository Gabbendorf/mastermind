require 'players'
require 'ui'

RSpec.describe Players do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:players) {Players.new(ui)}

  it "creates the codemaker" do
    choice = "computer"

    codemaker = players.codemaker(choice)

    expect(codemaker.type).to eq("computer")
  end

  it "creates the codebreaker" do
    choice = "human player"

    codebreaker = players.codebreaker(choice)

    expect(codebreaker.name).to eq("Gabriella")
  end

end
