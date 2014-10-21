def range(start, finish) # Range from first, last elements
  return [finish] if start == finish
  [start].concat(range(start + 1, finish))
end

def sum(arr) # Array Sum
  return arr.inject(:+) if arr.count <= 1
  arr.pop + (sum(arr))
end

def exp(b, n) # Raise b to the nth power
  return 1 if n == 0
  b * exp(b, n - 1)
end

def exp2(b, n) # Raise b to the nth power FASTER
  return 1 if n == 0
  return b if n == 1
  if n.even?
    exp(b, n / 2) * exp(b, n / 2)
  else
    b * ( exp(b, (n - 1) / 2) * exp(b, (n - 1) / 2) )
  end
end

def fibonacci(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  
  fibonacci(n - 1) << fibonacci(n - 1)[-1] + fibonacci(n-1)[-2]  
end

def binary_search(array, target)
  return nil if array.empty?
  mid = array.count / 2
  return mid if target == array[mid]
  
  left = array[0...mid]
  right = array[mid..array.count]
  
  target > array[mid] ? mid + binary_search(right,target) : binary_search(left, target)  
end

def make_change(amount, coins = [50, 25, 10, 5, 1])
  return [] if amount == 0
  
  perfect_change = []
  
  coins.each do |coin|
    next if coin > amount
    remainder = amount - coin
    perfect_change << [coin].concat( make_change(remainder, coins) )
  end
  
  perfect_change.sort_by{ |coins| coins.count }.first
end
  
    

class Array
  
  def deep_dup
    duplicate = self.select { |el| !el.is_a?(Array) }
    return duplicate unless self.any? { |el| el.is_a?(Array) }
    
    self.each do |el|
      duplicate << el.deep_dup unless duplicate.include? (el)
    end
    
    duplicate
  end
end