def remix(arr) 
  mixers = make_mixers(arr)
  arr.each_with_index do |pair, idx|
    pair[1] = mixers[idx]
  end

  arr
end

def randomizer(mixers)
  mixers.shuffle
end

def make_mixers(arr)
  mixers=[]
  arr.each do |pair|
    mixers << pair[1]
  end
  
  randomizer(mixers)
end