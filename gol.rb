require '/Users/vkajjam/dev/game_of_life/board.rb'

class Gol
  attr_accessor :size

  def initialize(size, live_cells, app)

    @app = app
    @app.nostroke
    @size = size

    @cell_width = @app.width  / size 
    @cell_height = @app.height / size 
    @board = Board.new size, live_cells
  end

  def tick
    @new_live_cells = @board.evolve
    @board = Board.new @size, @new_live_cells
  end


  def draw
    @app.clear
    @board.live_cells.each do |coordinates|
      x = coordinates[0]
      y = coordinates[1]


    @app.fill rgb(0x30, 0x30, 0xBB)

    @app.rect :left => x * @cell_width,
                :top => y * @cell_height, 
                :width => @cell_width,
                :height => @cell_height
    end
  end

end


Shoes.app(:title => 'TDD Game of Life', :height => 300, :width => 300) do
  app = self

  # Pulsar(period 3)

  @initial_live_cells = 

  [
    [2,4], [2,5], [2,6], [2,10], [2,11], [2,12],
    [4,2], [4,7], [4,9], [4,14],
    [5,2], [5,7], [5,9], [5,14],
    [6,2], [6,7], [6,9], [6,14],
    [7,4], [7,5], [7,6], [7,10], [7,11], [7,12],

    [9,4], [9,5], [9,6], [9,10], [9,11], [9,12],
    [10,2], [10,7], [10,9], [10,14],
    [11,2], [11,7], [11,9], [11,14],
    [12,2], [12,7], [12,9], [12,14],
    [14,4], [14,5], [14,6], [14,10], [14,11], [14,12]
  ]

  gol = Gol.new(18, @initial_live_cells, app)
  # gol = Gol.new(5, [ [2,1], [2,2], [2,3] ], app) # Blinker period(2)
  # gol = Gol.new(6, [ [1,2], [2,2], [3,2], [2,3], [3,3], [4,3] ], app) # Toad period(2)
  # gol = Gol.new(6, [ [1,3], [1,4], [2,4], [3,1], [4,1], [4,2] ], app) # Beacon period(2)


  gol.draw

  animate(2) do
    gol.tick
    gol.draw
  end
  
end