
# Mastermind

The game is played using:

* a decoding board, with a row where 4 code pegs of different colors are placed by the codemaker, and eight additional rows for the codebreaker;
* code pegs of six different colors, which will be placed on the board;
* and key pegs, some colored red, some white, which will be placed according to the guess result.

## Rules

One player becomes the codemaker, the other the codebreaker. The codemaker chooses a pattern of four code pegs.
The codebreaker tries to guess the pattern, in both order and color, within eight turns. Each guess is made by placing a row of code pegs on the decoding board. Once placed, the codemaker provides feedback by placing from zero to four key pegs. A red key peg is placed for each code peg from the guess which is correct in both color and position. A white key peg indicates the existence of a correct color code peg placed in the wrong position.

If there are duplicate colours in the guess, they cannot all be awarded a key peg unless they correspond to the same number of duplicate colours in the hidden code. For example, if the hidden code is white-white-black-black and the player guesses white-white-white-black, the codemaker will award two colored key pegs for the two correct whites, nothing for the third white as there is not a third white in the code, and a colored key peg for the black. No indication is given of the fact that the code also includes a second black.

## When does the game end

Once feedback is provided, another guess is made; guesses and feedback continue to alternate until either the codebreaker guesses correctly, or eight incorrect guesses are made.

### How to run the tests from terminal:

From main directory: `rspec spec` to run all tests inside `spec` directory

### How to include color when running the tests:

To add color from the command line: `rspec spec --color`

### How to run the game from terminal

From `lib` directory: `ruby execute.rb`
