def transpose(arr)
  i = 0
  transposed = arr
  #transposed =  [[0,0],[0,0]]
  #transposed = Array.new {Array.new}
  while i < arr.length
    j = 0
    while j < arr.length
      transposed[i][j] = arr[j][i]
     # transposed[j][i] = arr[i][j]
      j += 1
    end
    i += 1
  end
  transposed
end


rows = [[1, 2], [3, 4]]

p transpose(rows)