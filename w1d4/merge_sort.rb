def merge_sort(array)
  return [] if array.count == 0
  return array if array.count == 1
  
  mid = array.count / 2
  left = array[0...mid]
  right = array[mid..array.count]
  
  merge(merge_sort(left), merge_sort(right))
end

def merge(arr1, arr2)
  merged_array = []
  
  return arr1 if arr2.empty?
  return arr2 if arr1.empty?
  
  merged_array << ( arr1[0] < arr2[0] ? arr1.shift : arr2.shift )
  
  merged_array.concat( merge(arr1, arr2))
end

def subsets(set)
  return [[]] if set.empty?
  subs = subsets( set.take( set.count - 1 ) )
  
  subs.concat( subs.map { |sub| sub + [set.last] } )
end