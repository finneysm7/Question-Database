def factors(num)
  1.upto(num) do |i|
    print "#{i}, " if num % i == 0
  end
end