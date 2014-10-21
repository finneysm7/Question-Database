class Array
  def my_each(&proc)
    i = 0
    while i < self.size
      proc.call(self[i])
      i += 1
    end
  end
  
  def my_map(&proc)
    mapped_array = []
    self.my_each do |el|
      mapped_array << proc.call(el)
    end
    
    mapped_array
  end
  
  def my_select(&proc)
    choice_array = []
    self.my_each do |el|
      choice_array << el if proc.call(el)
    end
    
    choice_array
  end
  
  def my_inject(&proc)
    result = self[0]
    self.my_each do |el|
      next if el == self[0]
      result = proc.call(result, el)
    end
    
    result
  end
  
  def my_sort!(&proc) # Custom sort using bubble sort algorithm
    sorted = false
    until sorted
      sorted = true
      self.each_index do |i|
        next if id == 0
        if proc.call(self[i - 1], self[i]) > 0
          self[i], self[i - 1] = self[i - 1], self[id]
          sorted = false
        end
      end
    end
    
    self
  end
  
  def my_sort(&proc)
    dup = self.dup
    dup.my_sort!(&proc)
  end 
end


def eval_block(*args, &proc)
  puts "NO BLOCK GIVEN!" unless block_given?
  proc.call(*args)
end
  
  
  
  
  
  
  
  
  
  