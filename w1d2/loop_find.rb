def loop_find
  max_value = 1000000000
  251.upto(max_value) do |num|
    if num % 7 == 0
      puts num
      break
    end
  end
end