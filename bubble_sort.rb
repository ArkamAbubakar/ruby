def bubble_sort(arr)
	for i in 0..arr.length - 2
		for j in i..arr.length - 1
			if arr[j] < arr[i]
				temp = arr[j]
				arr[j] = arr[i]
				arr[i] = temp
			end
		end
	end
	arr
end