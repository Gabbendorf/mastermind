require_relative 'colour_list'
require_relative 'board'
require_relative 'peg_colour'
require_relative 'colour_list'

class Ui

  def initialize(stdin, stdout)
    @stdin = stdin
    @stdout = stdout
  end

  LOGO =  %q!               __  __           _____ _______ ______ _____  __  __ _____ _   _ _____
              |  \/  |   /\    / ____|__   __|  ____|  __ \|  \/  |_   _| \ | |  __ \
              | \  / |  /  \  | (___    | |  | |__  | |__) | \  / | | | |  \| | |  | |
              | |\/| | / /\ \  \___ \   | |  |  __| |  _  /| |\/| | | | | . ` | |  | |
              | |  | |/ ____ \ ____) |  | |  | |____| | \ \| |  | |_| |_| |\  | |__| |
              |_|  |_/_/    \_\_____/   |_|  |______|_|  \_\_|  |_|_____|_| \_|_____
            !

  def print_logo
    @stdout.puts LOGO
  end

  def choose_code_pattern_colour
    @stdout.puts "Choose a colour to create the code pattern (colours can be repeated):"
    @stdout.puts ColourList.new.prepare_list
    begin
      colour = PegColour.new(@stdin.gets.chomp)
    rescue => exception
      @stdout.puts exception.message
      colour = choose_code_pattern_colour
    end
    colour
  end

  def confirm_computer_chose_pattern
    @stdout.puts "The code pattern is ready. The challenge begins!"
    @stdout.puts ""
  end

  def make_guess(player_name)
    @stdout.puts "#{player_name}, make your guess:"
    @stdout.puts "choose one colour at a time up to 4 colours (colours can be repeated)"
    @stdout.puts ColourList.new.prepare_list
    begin
      colour = PegColour.new(@stdin.gets.chomp)
    rescue => exception
      @stdout.puts exception.message
      colour = make_guess(player_name)
    end
    @stdout.puts ""
    colour
  end

  def print_history(history, board)
    @stdout.puts ""
    history.each do |result|
      @stdout.puts "GUESS: " + board.printable_history(result)[:guess] + ". FEEDBACK: " + board.printable_history(result)[:red_pegs] +
      " red peg/s, " + board.printable_history(result)[:white_pegs] +  " white peg/s.\n"
    end
    @stdout.puts ""
  end

  def declare_winner(player_name)
    @stdout.puts "Congratulations #{player_name}: YOU WON! "
  end

  def declare_loser(player_name)
    @stdout.puts "#{player_name}: GAME OVER!"
  end

end
