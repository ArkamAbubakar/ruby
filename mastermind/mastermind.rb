class Board
  @@colors = ["R", "O", "B", "Y", "G", "P"]

  def initialize
    @board = Array.new(12)
    @code = make_code
    @guess_num = 0
  end

  def make_code
    str = ""
    for i in 0..3
      str += @@colors[Random.rand(6)]
    end
    str
  end

  def guess(str)
    toret = ""
    used_indices = Array.new
    chars = str.upcase.split("")
    code_chars = @code.split("")

    i = 0
    loop do
      if chars[i] == code_chars[i]
        toret += "R"
        chars.delete_at(i)
        code_chars.delete_at(i)
      else
        i += 1
      end
      break if i == chars.length
    end
    w = 0
    star = 0
    for j in 0..chars.length - 1
      if code_chars.index(chars[j]) != nil
        w += 1
        code_chars.delete_at(code_chars.index(chars[j]))
      else
        star += 1
      end
    end
    toret += "W" * w + "*" * star
    
    toret
  end

  def print_board
    print "Your guesses\n--------------------------\n"
    @guess_num.times do |i|
      print "#{@board[i][0,4].join}\t#{@board[i][4]}\n"
    end
  end

  def play
    while @guess_num < 12 do
      puts "\n\n\n\nGuess a four color sequence using:\nR, O, B, Y, G, P (use no spaces!)"
      g = gets.chomp
      @board[@guess_num] = g.split("")
      result = guess(g)
      if result == "RRRR"
        puts "You win!"
        return
      end
      @board[@guess_num].push(result)
      @guess_num += 1
      print_board
    end
  end
end

b = Board.new
b.play