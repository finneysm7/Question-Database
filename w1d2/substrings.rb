def substrings(string)
  dictionary = File.readlines("dictionary.txt").map(&:chomp)
  get_subs(string, dictionary)
end
 
def is_valid?(arr, sub, dictionary)
  !arr.include?(sub) && dictionary.include?(sub)
end
  
def get_subs(string, dictionary)
  result=[]
  0.upto(string.length-1) do |idx|
    idx.upto(string.length-1) do |idx_alt|
      sub =  string[idx..idx_alt]
      result << sub if is_valid?(result, sub, dictionary)
    end
  end
  result
end



