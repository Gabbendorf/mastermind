require 'colour_list'

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

  def choose_code_pattern_colour(colours_list)
    @stdout.puts "Choose a colour to create the code pattern (colours can be repeated):"
    @stdout.puts colours_list
    begin
      colour = PegColour.new(@stdin.gets.chomp)
    rescue => exception
      @stdout.puts exception.message
      colour = choose_code_pattern_colour(colours_list)
    end
    colour
  end

  def confirm_computer_chose_pattern
    @stdout.puts "The code pattern is ready."
  end

  def make_guess(colours_list, player_name)
    @stdout.puts "#{player_name}, make your guess: choose a colour (colours can be repeated)"
    @stdout.puts colours_list
    begin
      colour = PegColour.new(@stdin.gets.chomp)
    rescue => exception
      @stdout.puts exception.message
      colour = choose_code_pattern_colour(colours_list)
    end
    colour
  end

end