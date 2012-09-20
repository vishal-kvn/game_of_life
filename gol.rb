require 'rspec'

class Board
	def initialize(size, live_cells=[])
		@size = size
		@live_cells = live_cells

		if live_cells.count > size
			raise "invalid input"
		end
	end
end

describe Board do
	context "initialize board" do
		it "should create a new board" do
			lambda{board = Board.new}.should raise_error
			lambda{board = Board.new(1)}.should_not raise_error
			lambda{board = Board.new(2, [1,0])}.should_not raise_error
		end

		it "should not have cells outside its boundary" do
			lambda{board = Board.new(1, [[0,0],[1,0]])}.should raise_error
		end
	end
end