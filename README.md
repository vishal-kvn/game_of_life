This is my implementation of Conway's Game of Life(http://en.wikipedia.org/wiki/Conway's_Game_of_Life).

The GUI for this app uses ruby shoes(http://shoesrb.com/)

The steps to install ruby shoes can be found here - http://lethain.com/getting-started-shoes-os-x/

1. Download shoes from http://shoesrb.com/
2. Add this line to your bash profile
    PATH=/Applications/Shoes.app/Contents/MacOS:$PATH
3. Use the following command to open a shoes program
    shoes <file_name>

This app consists of 2 classes

1. Gol
2. Board

The Gol class reuses code from http://stungeye.github.com/tdd_game_of_life/ repository with a few modifications

The Board class has been implementd using TDD.

This app outputs the Oscillator Pulsar (period 3) pattern. 

To run the app - 

1. Clone this repository from github 
2. cd into the app directroy 
3. Run the following commmand -
    shoes gol.rb

The app has been tested for the following patterns - 

1. Blinker (period 2)
2. Toad (period 2)
3. Beacon (period 2)
  
