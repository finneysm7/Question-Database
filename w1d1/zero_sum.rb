class Array
  def zero_sum
    i = 0
    zero_pairs = []
    while (i < self.length-1)
      j = i + 1
      while (j < self.length)
        if self[i] + self[j] == 0
          zero_pairs << [i, j]
        end
        j += 1
      end
      i += 1
    end
    zero_pairs
  end
end