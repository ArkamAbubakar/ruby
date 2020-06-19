class Knight
  def initialize(row, col)
    unless row > 7 || col > 7 || row < 0 || col < 0
      @row = row
      @col = col
    else
      @row = 0
      @col = 0
    end
  end

  def all_moves
    to_ret = []
    -2.upto(2) do |x|
      next if x == 0
      -2.upto(2) do |y|
        next if y == 0
        unless x.abs - y.abs == 0
          newx = @row+y
          newy = @col+x
          if newx >= 0 && newx <= 7 && newy >= 0 && newy <= 7
            to_ret << [newx, newy]
          end
        end
      end
    end
    return to_ret
  end
end


k = Knight.new(4, 3)

puts k.all_moves.join(", ")

# expects: [[3, 1], [5, 1], [2, 2], [6, 2], [2, 4], [6, 4], [3, 5], [5, 5]]