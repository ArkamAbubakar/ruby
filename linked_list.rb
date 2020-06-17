class LinkedList
  attr_reader :size, :head, :tail


  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    node = Node.new(value)
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

  def prepend(value)
    node = Node.new(value)
    if @head == nil
      @head = node
      @tail = node
    elsif @size == 1
      @tail = @head
      @head = node
      @head.next_node = @tail
    else
      node.next_node = @head
      @head = node
    end
    @size += 1
  end

  def at(index)
    return nil if index >= @size
    current = @head
    index.times do |i|
      current = current.next_node
    end
    return current
  end

  def pop
    current = @head
    if current == nil
      return nil
    elsif @size == 1
      to_return = @head
      @head = nil
      @tail = nil
      @size -= 1
      return to_return
    end
    until current.next_node == @tail
      current = current.next_node
    end
    to_return = @tail
    current.next_node = nil
    @size -= 1
    return to_return
  end

  def contains?(value)
    return false if @head == nil

    current = @head
    until current == @tail
      if current.value == value
        return true
      end
    end
    return false
  end

  def find(value)
    return -1 if @head == nil
    index = 0
    current = @head
    until current.value == value
      if current.value == value
        return index
      end
      index += 1
    end
    return -1
  end

  def insert_at(value, index)
    return if index >= @size
    if index == @size - 1
      append(value)
    elsif index == 0
      prepend(value)
    else
      current = @head
      (index - 1).times do 
        current = current.next_node
      end

      to_add = Node.new(value, current.next_node)
      current.next_node = to_add
    end
    @size += 1
  end

  def remove_at(index)
    return if index >= @size || @size == 0
    if @size == 1
      @head = nil
      @tail = nil
    else
      current = @head
      (index-1).times do
        current = current.next_node
      end
      
      if current.next_node != nil
        current.next_node = current.next_node.next_node
      end
    end
    
    @size -= 1
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