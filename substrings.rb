def substrings(str, dict)
	toReturn = Hash.new(0)

	dict.each do |word|
		for i in 0..(str.length - 1)
			for j in i..str.length
				sub = str.slice(i, j-i)
				if word == sub
					toReturn[word] += 1
				end
			end
		end
	end
	
	toReturn
end