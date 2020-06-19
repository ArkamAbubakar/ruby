class Knight

  def initialize(coord)
    if is_valid_square(coord[0], coord[1])
      @coord = coord
    else
      @coord = [0, 0]
    end
  end

  def all_moves
    to_ret = []
    -2.upto(2) do |x|
      next if x == 0
      -2.upto(2) do |y|
        next if y == 0
        unless x.abs - y.abs == 0
          newx = @coord[0]+y
          newy = @coord[1]+x
          if is_valid_square(newx, newy)
            to_ret << [newx, newy]
          end
        end
      end
    end
    return to_ret
  end

  def is_valid_square(row, col)
    return row >= 0 && row <= 7 && col >= 0 && col <= 7
  end
end

class Node
  attr_reader :data, :sequence
  
  def initialize(data, sequence)
    @data = data
    @sequence = sequence
  end
end

def knight_moves(start, last)
  return if !is_valid_square(start[0], start[1]) || !is_valid_square(last[0], last[1])
  queue = [Node.new(start, [start])]

  loop do
    k = Knight.new(queue[0].data)
    k.all_moves.each do |elem|
      new_sequence = Array.new(queue[0].sequence)
      queue << Node.new(elem, new_sequence.push(elem))
    end

    shift = queue.shift
    if shift.sequence[-1] == last
      puts "It takes #{shift.sequence.length - 1} moves to go from #{start} to #{last}"
      shift.sequence.each {|square| puts "\t#{square}"}
      break
    end
  end
end

def is_valid_square(row, col)
  return row >= 0 && row <= 7 && col >= 0 && col <= 7
end