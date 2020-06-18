class Tree
  attr_reader :root

  def initialize(arr=[])
    @root = build_tree(arr)
    @values = arr
  end

  def build_tree(arr)
    return nil if arr.length == 0

    to_ret = Node.new(arr[0])
    values = [arr[0]]
    arr.each_with_index do |element, i|
      next if i == 0
      next if values.include? element

      current = to_ret
      node_placed = false

      until node_placed do
        if element < current.data && current.left == nil
          current.left = Node.new(element)
          node_placed = true
          values << element
        elsif element < current.data && current.left != nil
          current = current.left
        elsif element >= current.data && current.right == nil
          current.right = Node.new(element)
          node_placed = true
          values << element
        elsif element >= current.data && current.right != nil
          current = current.right
        end
      end
    end

    return to_ret
  end

  def insert(data)
    return if @values.include? data
    if @root == nil
      @root = Node.new(data)
      return
    end

    to_insert = Node.new(data)
    placed = false
    current = @root
    until placed do 
      if data < current.data
        if current.left == nil
          current.left = to_insert
          placed = true
        else
          current = current.left
        end
      else
        if current.right == nil
          current.right = to_insert
          placed = true
        else
          current = current.right
        end
      end
    end
  end

  def delete(data)
    current = @root
    previous = nil
    
    loop do 
      break if (data > current.data && current.right == nil) || (data < current.data && current.left == nil)
      if data < current.data
        previous = current
        current = current.left
      elsif data > current.data
        previous = current
        current = current.right
      else
        if current.left == nil && current.right == nil
          previous.left == current ? previous.left = nil : previous.right = nil
        elsif current.left != nil && current.right == nil
          current_is_root = (current == @root)
          previous.left == current ? previous.left = current.left : previous.right = current.left
          @root = current if current_is_root
        elsif current.left == nil && current.right != nil
          current_is_root = (current == @root)
          previous.left == current ? previous.left = current.right : previous.right = current.right
          @root = current if current_is_root
        else
          parent = parent_of_greatest_left(current)
          if current == parent
            if previous.left == current
              previous.left.data = current.left.data
              parent.left = nil
            else
              previous.right.data = current.left.data
              parent.left = nil
            end
          else
            if previous.left == current
              previous.left.data = parent.right.data
              parent.right = nil
            else
              previous.right.data = parent.right.data
              parent.right = nil
            end
          end
        end
        break
      end
    end
  end

  def parent_of_greatest_left(node)
    current = node
    previous = nil
    if current.left != nil && current.right == nil
      return current
    end
    until current.right == nil do
      previous = current
      current = current.right
    end
    return previous
  end

  def find(data)
    return nil if @root == nil
    current = @root
    until current.data == data do 
      if data < current.data
        if current.left == nil
          return nil
        end
        current = current.left
      elsif data > current.data
        if current.right == nil
          return nil
        end
        current = current.right
      end
    end
  end

  def level_order(root=@root)
    queue = [root]
    to_ret = []
    until queue.empty? do
      queue << queue[0].left if queue[0].left != nil
      queue << queue[0].right if queue[0].right != nil
      to_ret << queue.shift
    end
    return to_ret
  end

  def level_order_recursive(root=@root)
    level_order_recursive_helper(root, [root])
  end

  def level_order_recursive_helper(root, result)
    return if root == nil

    result << root.left unless root.left == nil
    result << root.right unless root.right == nil
    
    level_order_recursive_helper(root.left, result)
    level_order_recursive_helper(root.right, result)
    return result
  end

  def inorder(root=@root)
    inorder_helper(root)
  end

  def inorder_helper(root, result=[])
    inorder_helper(root.left, result) unless root.left == nil
    result << root unless root == nil
    inorder_helper(root.right, result) unless root.right == nil
    return result
  end

  def preorder(root=@root)
    preorder_helper(root)
  end

  def preorder_helper(root, result=[])
    result << root unless root == nil
    preorder_helper(root.left, result) unless root.left == nil
    preorder_helper(root.right, result) unless root.right == nil
    return result
  end

  def postorder(root=@root)
    postorder_helper(root)
  end

  def postorder_helper(root, result=[])
    postorder_helper(root.left, result) unless root.left == nil
    postorder_helper(root.right, result) unless root.right == nil
    result << root unless root == nil
    return result
  end

  def depth(node)
    return 0 if node.left == nil && node.right == nil
    left = 0
    right = 0
    if node.left != nil
      left = 1 + depth(node.left)
    end
    if node.right != nil
      right = 1 + depth(node.right)
    end
    left > right ? left : right
  end

  def balanced?(root=@root)
    return true if root == nil
    root.left == nil ? left = 0 : left = depth(root.left)
    root.right == nil ? right = 0 : right = depth(root.right)
    return (left - right).abs <= 1 && balanced?(root.left) && balanced?(root.right)
  end

  def rebalance!(root=@root)
    return if root == nil
    if balanced?(root) && root != nil
      rebalance!(root.left)
      rebalance!(root.right)
    else
      root.left = build_tree(setup_array(inorder(root.left)))
      root.right = build_tree(setup_array(inorder(root.right)))
    end
  end

  def setup_array(arr, ret=[])
    return if arr.length == 0
    ret << arr[arr.length/2].data
    return if arr.length == 1

    setup_array(arr[0..arr.length/2-1], ret)
    setup_array(arr[arr.length/2+1..arr.length-1], ret)

    return ret
  end
end

class Node
  attr_accessor :data, :left, :right

  def initialize(data=nil, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end
end

t = Tree.new([5, 6, 7, 9, 8, 4, 3, 2, 1])

t.rebalance!(t.root)

puts t.level_order.map {|elem| elem.data}.join(", ")