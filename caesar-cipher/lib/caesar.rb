#lib/caesar.rb
def caesar_cipher(str, shift)
  toReturn = ""
  letters = str.split("")
  upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	lower = "abcdefghijklmnopqrstuvwxyz"

  letters.each do |letter|
    newI = lower.index(letter.downcase).to_i + shift
    if !upper.index(letter).nil?
      toReturn += newI > 25 ? upper[newI - 26] : upper[newI]
    elsif !lower.index(letter).nil?
      toReturn += newI > 25 ? lower[newI - 26] : lower[newI]
    else
      toReturn +=  letter
    end
  end
  toReturn
end