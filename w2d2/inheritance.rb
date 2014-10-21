class Employee
  attr_accessor :boss, :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end
  
  def bonus(multiplier)
    self.salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :employees
  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end
  
  def bonus(multiplier)
    bonus_helper * multiplier
  end

#calculates salaries of all sub-employees
  def bonus_helper
    sum = 0
    employees.each do |employee|
      if employee.is_a?(Manager)
        sum += employee.salary 
        sum += employee.bonus_helper
      else
        sum += employee.salary
      end
    end
    sum
  end
end



mark = Manager.new("Mark", "Manager", 100_000, nil, [])
e1 = Employee.new("John", "Secretary", 2000, mark)
e2 = Employee.new("Jill", "Secretary", 3000, mark)
a = Manager.new("Aaron", "Manager", 120_000, nil, [mark])
mark.employees << e1 << e2
mark.boss = a

# p mark

puts "John's Bonus: #{e1.bonus(0.25)}"

puts "Mark's Bonus: #{mark.bonus(2)}"
puts "Aaron's Bonus: #{a.bonus(2)}"