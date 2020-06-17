class LinkedList
  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(node)
    if @head == nil
      @head = node
      @tail = node
    elsif @size == 1
      @tail = node
      @head.next_node = @tail
    else
      @tail.next_node = node
      @tail = node
    end
    @size += 1
  end

  def to_s
    str = ""
    current = @head
    while current != nil do
      str << "( #{current.value} ) -> "
      current = current.next_node
    end

    return str + "nil"
  end
end

class Node
  attr_accessor :next_node
  attr_reader :value
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end


list = LinkedList.new

a = Node.new(5)
b = Node.new(10)

list.append(a)
list.append(b)
