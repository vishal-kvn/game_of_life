class Board
	attr_accessor :size, :live_cells

	def initialize(size, live_cells=[[]])
		@size = size
		@live_cells = live_cells

		raise "invalid size" if size < 1

		unless  ( (live_cells.count == 1) && (live_cells.first.empty?) )
			live_cells.each do |cell|
				# refactor conditions
				if (((cell[0] >= size) || (cell[0] < 0)) || ((cell[1] >= size) || (cell[1] < 0 )))
					raise "cant have cells outside the board"
				end
			end
		end
	end

	def is_alive?(cell)
		@live_cells.include?(cell)
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

		@new_live_cells = []
		@dead_cells = []

		@size.times do |i|
			@size.times do |j|

				# Live Cell
				if is_alive?([i,j])

					if ( (neighbors([i,j]).count == 2) || (neighbors([i,j]).count == 3) ) 
						@new_live_cells << [i,j]
					else
						@dead_cells << [i,j]
					end

				# Dead Cell
				else
					if (neighbors([i,j]).count == 3) 
						@new_live_cells << [i,j]
					end
				end

			end
		end

		@new_live_cells
	end
end