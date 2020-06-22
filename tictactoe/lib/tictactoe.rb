class Board
	attr_reader :squares
	attr_reader :player
	attr_reader :open_squares

	def initialize
		@squares = Array.new(3) {Array.new(3)}
    @open_squares = 9
    @player1 = "X"
    @player2 = "O"
	end

  def player_move(player_number)
    puts "Player #{player_number}'s turn!"
		row = -1
		col = -1
		loop do
			puts "row?"
			row = gets.chomp.to_i;
			puts "column?"
			col = gets.chomp.to_i;
			break if player_move_helper(player_number, row, col)
			puts "Invalid choice!"
		end
	end

	def player_move_helper(player_number, row, col)
		if @squares[row][col] != nil
			return false
		else
			@open_squares -= 1
			player_number == 1 ? @squares[row][col] = @player1 : @squares[row][col] = @player2
			return true
		end
	end

	def check_win 
		for i in 0..@squares.length-1
			if @squares[i][0] == @squares[i][1] && @squares[i][0] == @squares[i][2] && @squares[i][0] != nil
				return @squares[i][0] == @player1 ? "Player 1" : "Player 2"
			end
			if @squares[0][i] == @squares[1][i] && @squares[0][i] == @squares[2][i] && @squares[0][i] != nil
				return @squares[0][i] == @player1 ? "Player 1" : "Player 2"
			end
		end
		if @squares[0][0] == @squares[1][1] && @squares[0][0] == @squares[2][2] && @squares[0][0] != nil
			return @squares[0][0] == @player1 ? "Player 1" : "Player 2"
		end
		if @squares[0][2] == @squares[1][1] && @squares[0][2] == @squares[2][0] && @squares[0][2] != nil
			return @squares[0][2] == @player1 ? "Player 1" : "Player 2"
		end
		return nil
	end

	def print_board
		print "     0    1    2\n0  #{@squares[0]}\n1  #{@squares[1]}\n2  #{@squares[2]}\n\n"
	end

	def play
		puts "\nWelcome to Tic Tac Toe!\n\nA game where 2 players alternate in choosing locations on a 3x3 grid\nuntil one gets three in a row!"
		while @open_squares > 0 do
			@open_squares % 2 == 1 ? player_move(1) : player_move(2)
      winner = check_win
      
			print_board
			if winner != nil
				puts "#{winner} has won!"
				return
			end
		end
		puts "Draw!"
	end
end

b = Board.new
b.play