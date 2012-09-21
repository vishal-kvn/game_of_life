require 'rspec'
require '/Users/vkajjam/dev/game_of_life/board.rb'


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

		it "live_cells is an array of arrays" do
			board = Board.new(2)
			board.live_cells[0].should be_a_kind_of Array
		end
	end

	context "Check if a cell is live or Dead" do
		it "should return ture if alive" do
			board = Board.new(2, [ [1,0] ])
			board.is_alive?([1,0]).should == true
			board.is_alive?([0,0]).should == false
		end 
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

		describe "Live Cell < 2 neighbors" do

			it "should die" do
				board = Board.new(1, [[0,0]])
				board.evolve.should_not include [0,0]

				board1 = Board.new(2,[[0,0], [0,1]])
				board1.evolve.should_not include ([0,0] || [0,1])
				# board1.evolve.should_not include [0,1]
			end

		end

		# board1.evolve.should == [[0,0], [0,1], [1,0], [1,1]]
		describe "Live Cell 2 neighbors" do

			it "should live on" do
				board1 = Board.new(2,[[0,0], [0,1], [1,0]])
				board1.evolve.should include ([0,0])
				board1.evolve.should include ([1,0])
				board1.evolve.should include ([0,1])
			end

		end

		describe "Live Cell 3 neighbors" do

			it "should live on" do
				board = Board.new(4, [ [0,0], [0,1], [2,1], [0,2], [3,2], [1,3] ])
				board.evolve.should include ([0,1])
				# board.evolve.should include ([1,1])
			end

		end

		describe "Live Cell > 3 neighbors" do

			it "should die" do
				board = Board.new(4, [ [0,0], [0,1], [1,1], [2,1], [0,2], [3,2], [1,3] ])
				board.evolve.should_not include ([1,1])
				# board.evolve.should include ([1,1])
			end

		end


		describe "Dead Cell with exactly 3 neighbors" do

			it "should come back to life" do
				board1 = Board.new(2,[[0,0], [0,1], [1,0]])
				board1.evolve.should include ([1,1])
				board1.evolve.should == [[0,0], [0,1], [1,0], [1,1]]
			end

			it "should not come back to life" do
				board = Board.new(4, [ [0,0], [0,1], [2,1], [0,2], [3,2], [1,3] ])
				board.evolve.should_not include ([1,1])
				# board.evolve.should include ([1,1])
			end			

		end

		describe "Oscillators" do
			it "should give a valid blinker pattern" do
				board = Board.new(5, [ [2,1], [2,2], [2,3] ])
				board.evolve.should == [[1,2], [2,2], [3,2]]
			end

			it "should give a valid toad pattern" do
				board = Board.new(6, [ [1,2], [2,2], [3,2], [2,3], [3,3], [4,3] ])
				# board.evolve.should match_array [ [2,1], [1,2], [4,2], [1,3], [4,3], [3,4] ]
				board.evolve.should =~ [ [2,1], [1,2], [4,2], [1,3], [4,3], [3,4] ]
			end
		end

	end
	
end

# http://stackoverflow.com/questions/2978922/rspec-array-should-another-array-but-without-concern-for-order