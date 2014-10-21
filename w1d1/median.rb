def median(arr)
  arr.sort!
  length = arr.length
  if length % 2 == 0 # is even
    (arr[length / 2] + arr[length / 2 - 1]) / 2.0
  else
    arr[length / 2]
  end
end


puts median([1, 5, 3, 4])