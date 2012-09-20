require 'rspec'

#Live Cell
# < 2 neighbors dies
# > 3 neighbors dies
# 2 || 3 neighbors lives on

#Dead Cell
# 3 neighbors - comes back to life

class Board
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
end

describe Board do
	context "Create Board" do
		it "should have atleast cell" do
			lambda{board = Board.new}.should raise_error
			lambda{board = Board.new(1)}.should_not raise_error
			lambda{board = Board.new(2, [1,0])}.should_not raise_error
			lambda{board = Board.new(-1)}.should raise_error("invalid size")
		end

		it "should not have cells outside its boundary" do
			lambda{board = Board.new(1, [[0,0],[1,0]])}.should raise_error("cant have cells outside the board")
		end

		it "should not have cells with negative co-ordinates" do
			lambda{board = Board.new(1, [[-1,0]])}.should raise_error("cant have cells outside the board")
		end
	end

	context "Board with one cell"

	context "Board with four cell"

	context "Board with nine cell"
end