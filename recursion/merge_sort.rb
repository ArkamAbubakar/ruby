def merge_sort(arr)
  merge_helper(arr, arr[0..arr.length/2-1], arr[arr.length/2..arr.length-1])
end

def merge_helper(arr, left, right)
  if left.length != 1
    temp_left = merge_helper(left, left[0..left.length/2-1], left[left.length/2..left.length-1])
  else
    temp_left = left
  end
  if right.length != 1
    temp_right = merge_helper(right, right[0..right.length/2-1], right[right.length/2..right.length-1])
  else
    temp_right = right
  end
  return merge(temp_left, temp_right)
end

def merge(left, right)
  toret = []
  while !left.empty? || !right.empty? do
    if !left.empty? && right.empty?
      toret << left.shift
    elsif left.empty? && !right.empty?
      toret << right.shift
    else
      if left[0] < right[0]
        toret << left.shift
      else
        toret << right.shift
      end
    end
  end
  return toret
end


print merge_sort([2, 1, 4, 8, 3, 0, 7, 6]).to_s + "\n"