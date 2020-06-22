class Connect4
  attr_reader :board

  def initialize
    @board = Array.new(6) {Array.new(7)}
  end
  
  def move(color, column)
    return false if column > 6 || column < 0
    row = @board.length - 1
    (@board.length-1).downto(0) do |row|
      if @board[row][column] == nil
        @board[row][column] = color
        return [row, column]
      end
    end
    return nil
  end

  # last move played
  def game_over(mover, row, col)
    # ROW
    check_row = [[row, col],[row, col + 1],[row, col + 2],[row, col + 3]]
    4.times do
      if check_row[3][1] <= 6
        tokens = check_row.map { |elem| @board[elem[0]][elem[1]] }
        if tokens.all? {|elem| elem == mover}
          return mover
        end
      end
      check_row.each {|elem| elem[1] -= 1}
    end

    # COL
    if row < 3
      check_col = [[row, col], [row + 1, col], [row + 2, col], [row + 3, col]]
      tokens = check_col.map { |elem| @board[elem[0]][elem[1]] }
      if tokens.all? {|elem| elem == mover}
        return mover
      end
    end

    # MAJOR DIAGONAL
    check_diag_major = [[row, col], [row + 1, col + 1], [row + 2, col + 2], [row + 3, col + 3]]
    4.times do
      if check_diag_major[3][1] <= 6 && check_diag_major[3][0] <= 5
        tokens = check_diag_major.map { |elem| @board[elem[0]][elem[1]] }
        if tokens.all? {|elem| elem == mover}
          return mover
        end
      end
      check_diag_major.each do |elem|
        elem[0] -= 1
        elem[1] -= 1
      end 
    end

    # MINOR DIAGONAL
    check_diag_minor = [[row, col], [row + 1, col - 1], [row + 2, col - 2], [row + 3, col - 3]]
    4.times do 
      if check_diag_minor[0][0] >= 0 && check_diag_minor[0][1] >= 0
        tokens = check_diag_minor.map { |elem| @board[elem[0]][elem[1]] }
        if tokens.all? {|elem| elem == mover}
          return mover
        end
      end
      check_diag_major.each do |elem|
        elem[0] -= 1
        elem[1] += 1
      end 
    end
    return nil
  end

  def board_full?
    @board.each do |elem|
      if elem.index(nil) != -1
        return false
      end
    end
    return true
  end

  def print_board
    print "\n\n\n\n"
    @board.each do |elem|
      print "#{elem}\n"
    end
  end

  def play
    mover = "R"
    won = false
    loop do 
      if !board_full? && !won
        loop do
          puts "In which column would you like to place a #{mover} token?"
          col = gets.chomp.to_i
          move = move(mover, col)
          if move != nil
            if game_over(mover, move[0], move[1])
              won = true
            end
            break
          end
          puts "Invalid move!"
        end
      end
      mover = mover == "R" ? "B" : "R"
    end
  end
end