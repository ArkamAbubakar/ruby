def fibs(n)
  result = 0
  n.downto(0) {|i| result += i}
  result
end

def fibs_rec(n)
  return 0 if n == 0
  return 1 if n == 1
  fibs_rec(n-1) + fibs_rec(n-2)
end