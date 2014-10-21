class MyHashSet 
  
  def initialize
    @store = {}
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store.has_key?(el) 
  end
  
  def delete(el)
    if (@store.include?(el))
      @store.delete(el)
      true
    else
      false
    end  
  end
  
  def to_a
    @store.keys
  end
  
  def union(set2)
    @store.merge(set2)
  end
  
  def intersect(set2)
    intersections = {}
    @store.each do |key, value|
      if set2.include?(key)
        intersections << key
      end
  end
  
  def minus(set2)
    minuses = {}
    @store.each do |key, value|
      unless set2.include?(key)
        intersections << key
      end
    end
  
end