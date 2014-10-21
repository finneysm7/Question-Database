#!/usr/bin/env ruby

def rpn
  file = ARGV[0]
  nums = []
  last_two = []
  expression_array = gets_input(file)
  expression_array.each do |ele|
    if ele =~ /\d+/
      nums << ele.to_i
    elsif ele == "+"
      nums << plus(nums.pop(2))
    elsif ele == "-"
      nums << minus(nums.pop(2))
    elsif ele == "*"
      nums << times(nums.pop(2))
    elsif ele == "/"
      nums << divide(nums.pop(2))
    else
      break
    end
  end
    
    puts nums
end

def gets_input(file)
  if file == nil
    puts "Please enter your expression!"
    input = gets.chomp!.split(" ")
  else
    input = File.read(file).split(" ")
  end
  
  input
end

def plus (arr)
  arr[0] + arr[1]
end

def minus (arr)
  arr[0] - arr[1]
end

def times (arr)
  arr[0] * arr[1]
end

def divide (arr)
  arr[0] / arr[1]
end

if __FILE__ == $PROGRAM_NAME
  rpn
end




  