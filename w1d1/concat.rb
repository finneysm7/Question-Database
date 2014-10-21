def my_concat(arr)
  arr.inject("") do |start, string|
    start + string
  end
end

puts my_concat(["Yay ", "for ", "strings!"])