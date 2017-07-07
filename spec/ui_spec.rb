require_relative 'spec_helper'
require_relative '../lib/ui'
require_relative '../lib/human_player'
require_relative '../lib/pattern'
require_relative '../lib/result'
require_relative '../lib/feedback'
require_relative '../lib/board'
require_relative '../lib/peg_colour'
require_relative '../lib/players'

RSpec.describe Ui do

  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let(:ui) {Ui.new(input, output)}
  let(:pattern) {double}
  let(:board) {Board.new(8, pattern)}
  let(:codebreaker) {HumanPlayer.new("Gabriella", ui, 4)}

  it "prints the game logo" do
    output = double("output")
    ui = Ui.new(input, output)

    expect(output).to receive(:puts).with(Ui::LOGO)

    ui.print_logo
  end

  it "asks for codemaker and raises error message if input is wrong" do
    input = StringIO.new("robot\nc")
    ui = Ui.new(input, output)
    players = Players.new(ui)

    codemaker = ui.choose_codemaker(players)

    expect(output.string).to eq("Select the codemaker ('c' = computer or 'h' = human player)\nI didn't understand :(\nSelect the codemaker ('c' = computer or 'h' = human player)\n")
    expect(codemaker.name).to eq("computer-codemaker")
  end

  it "asks for codemaker and returns instance of it" do
    input = StringIO.new("c")
    ui = Ui.new(input, output)
    players = Players.new(ui)

    codemaker = ui.choose_codemaker(players)

    expect(output.string).to eq("Select the codemaker ('c' = computer or 'h' = human player)\n")
    expect(codemaker.name).to eq("computer-codemaker")
  end

  it "asks for codebreaker and raises error message if input is wrong" do
    input = StringIO.new("human\nh\nGabi")
    ui = Ui.new(input, output)
    players = Players.new(ui)

    codebreaker = ui.choose_codebreaker(players, board)

    expect(output.string).to eq("Select the codebreaker ('c' = computer, 'h' = human player or 's' = smart computer)\nI didn't understand :(\nSelect the codebreaker ('c' = computer, 'h' = human player or 's' = smart computer)\nEnter player's name:\n")
    expect(codebreaker.name).to eq("Gabi")
  end

  it "asks for codebreaker and returns instance of it" do
    input = StringIO.new("h\nGabi")
    ui = Ui.new(input, output)
    players = Players.new(ui)

    codebreaker = ui.choose_codebreaker(players, board)

    expect(output.string).to eq("Select the codebreaker ('c' = computer, 'h' = human player or 's' = smart computer)\nEnter player's name:\n")
    expect(codebreaker.name).to eq("Gabi")
  end

  it "asks for name for human player" do
    input = StringIO.new("Gabriella")
    ui = Ui.new(input, output)

    name = ui.ask_human_player_name

    expect(output.string).to eq("Enter player's name:\n")
    expect(name).to eq("Gabriella")
  end

  it "asks for colour from human codemaker for code pattern and raises error message if wrong input" do
    input = StringIO.new("grey\ngreen")
    ui = Ui.new(input, output)

    peg = ui.choose_code_pattern_colour

    expect(output.string).to eq("Choose a colour to create the code pattern (colours can be repeated):\ngreen, pink, yellow, purple, blue, orange\nInvalid colour :(\nChoose a colour to create the code pattern (colours can be repeated):\ngreen, pink, yellow, purple, blue, orange\n")
    expect(peg.colour).to eq("green")
  end

  it "gets colour from human codemaker for code pattern and returns istance of it" do
    input = StringIO.new("green")
    ui = Ui.new(input, output)

    peg = ui.choose_code_pattern_colour

    expect(output.string).to include("Choose a colour to create the code pattern (colours can be repeated):",
                                      "green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  it "confirms computer chose a code pattern" do
    ui.confirm_computer_chose_pattern

    expect(output.string).to include("The code pattern is ready. The challenge begins!", "")
  end

  it "gets colour from codebreaker to make guess" do
    input = StringIO.new("grey\nviolet\ngreen")
    ui = Ui.new(input, output)

    peg = ui.make_guess(codebreaker.name)

    expect(output.string).to include("Gabriella, make your guess:")
    expect(output.string).to include("choose one colour at a time up to 4 colours (colours can be repeated)")
    expect(output.string).to include("green, pink, yellow, purple, blue, orange")
    expect(peg.colour).to eq("green")
  end

  def set_up_result(colour_strings, red_pegs, white_pegs)
    peg_colours = colour_strings.map {|colour| PegColour.new(colour)}
    guess = Pattern.new(peg_colours)
    feedback = Feedback.new(red_pegs, white_pegs)
    Result.new(guess, feedback)
  end

  it "prints an history after each guess" do
    result1 = set_up_result(["purple", "blue", "yellow", "green"], 1, 2)
    result2 = set_up_result(["blue", "blue", "pink", "green"], 3, 0)
    board.keep_track_of_results(result1)
    board.keep_track_of_results(result2)

    ui.print_history(board.history, board)

    expect(output.string).to include("", "GUESS: purple, blue, yellow, green. FEEDBACK: 1 red peg/s, 2 white peg/s.\n",
                                      "GUESS: blue, blue, pink, green. FEEDBACK: 3 red peg/s, 0 white peg/s.\n", "")
  end

  it "prints message for codemaker winner" do
    codemaker = HumanPlayer.new("Gabriella", ui, 4)

    ui.codemaker_is_winner(codemaker.name)

    expect(output.string).to include("Gabriella wins!")
  end

  it "prints message for codebreaker winner" do
    codebreaker = Computer.new("computer", 4)

    ui.codebreaker_is_winner(codebreaker.name)

    expect(output.string).to include("computer wins!")
  end

end
