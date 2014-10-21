class Student
  attr_accessor :name, :courses
  
  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end
  
  def name
    @first + " " + @last
  end

  def enroll(course)
    error = false
    self.courses.each do |existing_class| unless self.courses.empty?
      error = existing_class.conflicts_with?(course)
    end
    if error == false
      self.courses << course
      course.add_student(self) 
    end
  end
  
  def course_load
    dept_credits = {}
    @courses.each do |course|
      if dept_credits.has_key?(course.department)
        dept_credits[course.department] += course.num_credits
      else
        dept_credits[course.department] = course.num_credits
      end
    end
    dept_credits
  end
end


class Course
  attr_accessor :name, :department, :num_credits, :days, :time_block
  
  def initialize(name, department, num_credits, days, time_block)
    @days = days
    @time_block = time_block
    @name = name
    @department = department
    @num_credits = num_credits
  end
  
  def students
    @students ||= []
  end
  
  def add_student(student)
    self.students << student
    student.enroll(self)
  end
  
  def conflicts_with?(second_course)
    self.days.each do |day|
      second_course.days.each do |day_alt|
        return true if day == day_alt && self.time_block == second_course.time_block
      end
    end
  
    false
  end
  
end
