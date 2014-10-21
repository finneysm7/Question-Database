def range(start, finish)
	return [finish] if start == finish
	[start].concat(range(start+1, finish))
end

def i_sum(arr)
	result = 0
	arr.each do |i|
		result += i
	end
	result
end

def r_sum(arr)
	return arr.first if arr.count == 1
	arr.first + r_sum(arr[1..-1])

end

def exp1(base, num)
	return 1 if num == 0 
	base * exp1(base, num-1)
end

def exp2(base, num)
	return 1 if num == 0
	return base if num == 1
	if num.even?
		exp2(base, num / 2) * exp2(base, num / 2)
	else
		base * (exp2(base, (num - 1) / 2) * (exp2(base, (num - 1) / 2)))
	end
end



def i_fibonacci(n)
	result = []
	term1 = 0
	term2 = 1
	n.times do 
		result << term1
		term1, term2 = term2, term1 + term2
	end
	result
end

def r_fibonacci(n)
	return [1] if n == 1
	return [1, 1] if n == 2

	# old_terms  = [n-1, n-2]
	# new_term = old_terms.inject(:+)
	r_fibonacci(n-1) << r_fibonacci(n-1)[-1] + r_fibonacci(n-1)[-2]
end

def subsets(set)
	return [[]] if set.empty?

	smaller_set = set.take(set.count - 1)
	smaller_subsets = subsets(smaller_set)
	bigger_subsets = []

	smaller_subsets.each do |smaller_subset|
		bigger_subsets << smaller_subset + [set.last]
	end

	smaller_subsets + bigger_subsets
end

def bsearch(nums, target)
	small = 0
	large = nums.length
	mid = large / 2
	return mid if nums[mid] == target
	return nil if nums.count == 0

	left = [0...mid]
	right = [mid..large]
	
	if target < nums[mid]
		bsearch(left, target)
	elsif target > nums[mid] 
		mid + bsearch(right, target)
	end
end




class Array ## currently doesn't correctly handle something like [4, 3, [4, 1], 2]
	def deep_dup
		duplicate = self.select { |el|  !el.is_a?(Array) }
		return duplicate unless self.any? { |el| el.is_a?(Array) }

		self.each do |el|
			duplicate << el.deep_dup unless duplicate.include?(el)
		end

		duplicate
	end

end



array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p bsearch(array, 7)




















