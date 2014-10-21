def bubble_sort(arr)
  sorted = false
  
  until sorted
    sorted = true
    1.upto(arr.size-1) do |num|
      if arr[num] < arr[num-1]
        swap(arr, num , num-1)
        sorted = false
      end
    end
  end
  
 arr
end


def swap(arr, idx1, idx2)
  arr[idx1], arr[idx2] = arr[idx2], arr[idx1]
  
  arr
end