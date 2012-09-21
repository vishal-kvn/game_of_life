require 'rspec'

#Live Cell
# < 2 neighbors dies
# > 3 neighbors dies
# 2 || 3 neighbors lives on

#Dead Cell
# 3 neighbors - comes back to life

class Board
	attr_accessor :size, :live_cells

	def initialize(size, live_cells=[])
		@size = size
		@live_cells = live_cells

		raise "invalid size" if size < 1

		live_cells.each do |cell|
			# refactor condition
			if (((cell[0] >= size) || (cell[0] < 0)) || ((cell[1] >= size) || (cell[1] < 0 )))
				raise "cant have cells outside the board"
			end
		end
	end

	def distance(cell1, cell2)
		x = cell1[0] - cell2[0]
		y = cell1[1] - cell2[1]
		Math.sqrt( (x * x) + (y * y) )
	end

	def neighbors(ccell)
		@live_cells.inject([]) do |result, cell|
			d = distance(ccell, cell)
			if ( ( d == 1) || ( d == Math.sqrt(2)))
				result << cell
			end
			result
		end
	end

	def evolve
		[]
	end
end

describe Board do
	context "Create Board" do
		it "should have atleast cell" do
			lambda{board = Board.new}.should raise_error
			lambda{board = Board.new(1)}.should_not raise_error
			lambda{board = Board.new(2, [ [1,0] ])}.should_not raise_error
			lambda{board = Board.new(-1)}.should raise_error("invalid size")
		end

		it "should not have cells outside its boundary" do
			lambda{board = Board.new(1, [[0,0],[1,0]])}.should raise_error("cant have cells outside the board")
		end

		it "should not have cells with negative co-ordinates" do
			lambda{board = Board.new(1, [[-1,0]])}.should raise_error("cant have cells outside the board")
		end

		it "should return size of the board" do
			board = Board.new(2, [1,0])
			board.size.should == 2
		end

		it "should return live cells on the board" do
			board = Board.new(2, [ [1,0] ])
			board.live_cells.should == [[1,0]]
		end	

		pending "live_cells is an array of arrays"	
	end

	context "Get distance"	do
		it "should return distance between 2 nodes" do
			board = Board.new(5)
			board.distance([3,0], [0,4]).should == 5
		end
	end

	context "Distance between neighbors" do
		it "should be 1 or sqrt(2)" do
			board = Board.new(5)
			board.distance([1,1], [1,2]).should == 1
			board.distance([1,1], [2,2]).should == Math.sqrt(2)
		end
	end

	context "Get Neighbors" do
		it "should return array of neighbors" do
			board = Board.new(4, [ [0,0], [0,1], [2,1], [0,2], [3,2], [1,3] ])
			# board.size.should == 4
			board.neighbors([1,1]).should == [ [0,0], [0,1], [2,1], [0,2] ]
		end
	end

	context "Evolve" do
		context "Board with one cell" do
			it "should return 0 live cells" do
				board = Board.new(1, [[0,0]])
				board.evolve.should be_empty
			end
		end

		context "Board with four cells" do
			it "should return 0 live cells" do
				board1 = Board.new(2,[[0,0], [0,1]])
				board1.evolve.should be_empty
			end

			pending "should return 4 live cells" do
				board1 = Board.new(2,[[0,0], [0,1], [1,0]])
				board1.evolve.should == [[0,0], [0,1], [1,0], [1,1]]
			end
		end

		context "Board with nine cell" do

		end
	end
	
end