def stock_picker(arr) 
	toReturn = [0, 0]
	puts toReturn
	for buy in 0..arr.length - 2
		for sell in buy..arr.length - 1
			if arr[sell] - arr[buy] > arr[toReturn[1]] - arr[toReturn[0]]
				toReturn[0] = buy
				toReturn[1] = sell
			end
		end
	end
	puts toReturn
	return
end