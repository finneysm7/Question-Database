class Array
  def my_uniq
    unique = []
    self.each {|num| unique.include?(num) ? next : unique << num }
    unique
  end
end