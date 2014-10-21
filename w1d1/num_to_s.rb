def my_num_to_s(num, base)
  lookup = {
    0 => "0",
    1 => "1",
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "A",
    11 => "B",
    12 => "C",
    13 => "D",
    14 => "E",
    15 => "F"
  }
  
  check = true
  solution = ""
  i = 0
  while check
    solution << lookup[((num / (base ** i)) % base)]
    check = false if (num / (base ** i)) < 1
    i += 1
  end
  
  solution.reverse!
  while solution[0] == "0"
    solution.slice!(0)
  end
    solution
end

p my_num_to_s(234,2)