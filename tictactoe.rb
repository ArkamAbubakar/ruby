class Board
	attr_reader :squares
	attr_reader :player
	attr_reader :open_squares

	def initialize
		@squares = Array.new(3) {Array.new(3)}

		@open_squares = 9
	end

	def coin_flip
		puts "heads or tails"
		coin = gets.chomp.downcase
		xs = Random.rand(2)

		if coin != "heads" && coin != "tails"
			puts "Nice try, now I get X's"
			@computer = "X"
			@player = "O"
		elsif coin == xs
			@player = "X"
			@computer = "O"
		else
			@player = "O"
			@computer = "X"
		end
		return
	end

	def computer_move
		rand = Random.rand(@open_squares)
		i = -1

		for j in 0..@squares.flatten.length - 1
			if @squares.flatten[j] == nil && i != rand
				i += 1
			end
		end
		@open_squares -= 1
		@squares[i / 3][i % 3] = @computer
	end

	def player_move
		row = -1
		col = -1
		loop do
			puts "row?"
			row = gets.chomp.to_i;
			puts "column?"
			col = gets.chomp.to_i;
			break if @squares[row][col] == nil
			puts "Invalid choice!"
		end
		@open_squares -= 1
		@squares[row][col] = @player
	end

	def check_win 
		for i in 0..@squares.length-1
			if @squares[i][0] == @squares[i][1] && @squares[i][0] == @squares[i][2] && @squares[i][0] != nil
				return @squares[i][0] == @player ? "player" : "computer"
			end
			if @squares[0][i] == @squares[1][i] && @squares[0][i] == @squares[2][i] && @squares[0][i] != nil
				return @squares[0][i] == @player ? "player" : "computer"
			end
		end
		if @squares[0][0] == @squares[1][1] && @squares[0][0] == @squares[2][2] && @squares[0][0] != nil
			return @squares[0][0] == @player ? "player" : "computer"
		end
		if @squares[0][2] == @squares[1][1] && @squares[0][2] == @squares[2][0] && @squares[0][2] != nil
			return @squares[0][2] == @player ? "player" : "computer"
		end
		return nil
	end

	def print_board
		print "     0    1    2\n0  #{@squares[0]}\n1  #{@squares[1]}\n2  #{@squares[2]}\n\n"
	end

	def play
		coin_flip
		while @open_squares > 0 do
			if @player == "X"
				@open_squares % 2 == 1 ? player_move : computer_move
			else
				@open_squares % 2 == 1 ? computer_move : player_move
			end
			winner = check_win
			print_board
			if winner != nil
				puts "#{winner} has won!"
				return
			end
		end
	end
end