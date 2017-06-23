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

  def choose_pattern_colour
    @stdout.puts "Choose a colour for the pattern:"
    @stdin.gets.chomp
  end

  def repeat_pattern_colour
    @stdout.puts "Colour not available, choose another colour:"
    @stdin.gets.chomp
  end

  def confirm_computer_chose_pattern
    @stdout.puts "Computer chose a pattern."
  end

end
