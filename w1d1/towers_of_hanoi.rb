

def hanoi_towers(size)
  towers = [Array(1..size)]
  #size.times {empty_arr << 0 }
  towers << [] 
  towers << [] 
  
  unsolved = true
  while (unsolved) 
    p towers
    from = 0
    to = 0
    
    while validity(from)
      puts "Input the tower you want to select from"
      from = gets.chomp.to_i
      puts "Your input is invalid" if validity(from) 
    end
    
    while validity(to)
      puts "Input the tower you want to move to"
      to = gets.chomp.to_i
      puts "Your input is invalid" if validity(to) 
    end
    
    if towers[to-1].last == nil || towers[from-1].last == nil 
          towers[to-1] << towers[from-1].pop
    elsif towers[from-1].last < towers[to-1].last 
        puts "This move is not allowed"
    else
        towers[to-1] << towers[from-1].pop
     end
      unsolved = check_solution(towers, size)
  end
  puts "Congratulations! You solved it"
end

def check_solution(towers,size)
  correct_arr = Array(1..size)
  p correct_arr
  if correct_arr == towers[2]
    return false
  end
  true
end

def validity(num)
  if num != 1 && num != 2 && num != 3
    return true
  end
  false
end

hanoi_towers(2)
