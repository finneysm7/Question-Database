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
	return nil if nums.empty?
	large = nums.count
	mid = large / 2
	return mid if nums[mid] == target

	left = nums[0...mid]
	right = nums[mid..large]
	if target > nums[mid]
		mid + bsearch(right, target)
	else
		bsearch(left, target)
	end
end

def mergesort(nums)
	return nums if nums.length <= 1
	
	small = 0
	large = nums.length
	mid = large / 2

	left = nums[0...mid]
	right = nums[mid..large]
	merge(mergesort(left), mergesort(right))

end

def merge(arr1, arr2)
	size = arr1.length + arr2.length
	merged_array = []
	return merged_array if size == 0

	until merged_array.size == size
		return merged_array += arr2 if arr1.empty?
		return merged_array += arr1 if arr2.empty?
		arr1[0] < arr2[0] ? merged_array << arr1.shift : merged_array << arr2.shift
	end

	merged_array
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



arr1 = [0, 4]
arr2 = [1, 5]

#p merge(arr1, arr2)

arr_unsorted = [5, 0, 3, 10, 2, 20, 1, 1]
p mergesort(arr_unsorted)





