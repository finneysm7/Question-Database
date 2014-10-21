require 'set'

class WordChainer

  def initialize(dictionary_file_name)
    dict_array = []
    File.foreach(dictionary_file_name) do |word|
      dict_array << word.chomp
    end
    @dictionary = Set.new(dict_array)
  end


  def adjacent_words(word)
    adj_words_list = @dictionary.select { |w| adjacent_words?(word, w) }
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }
    until @current_words.empty? || @all_seen_words.include?(target)
      explore_current_words 
    end
    path = build_path(target)

    unless path.include?(source) && path.include?(target)
      return "There is no path between #{source} and #{target}!"
    end
    build_path(target)
  end

  def explore_current_words
    @current_words.each do |current_word|
      new_current_words = []
      adjacent_words(current_word).each do |adjacent_word|
        unless @all_seen_words.has_key?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end
      new_current_words.each do |word|
        # p "#{word} came from #{@all_seen_words[word]}"
      end
      # p new_current_words unless new_current_words.empty?
      @current_words = new_current_words
      # p "@current_words = #{@current_words}"
    end
  end

  def build_path(target)
    prior_word = target
    path = []
    until prior_word == nil
      path << prior_word
      prior_word = @all_seen_words[prior_word]

    end
    path.reverse
  end


end

def adjacent_words?(word1, word2)
  count = 0
  return false unless word1.length == word2.length
  arr1 = word1.split("")
  arr2 = word2.split("")
  arr1.each_index do |i|
    count += 1 unless arr1[i] == arr2[i]
    return false if count > 1
  end

  true if count == 1
end


# p adjacent_words?("ruby", "rube")
# p adjacent_words?("hello", "house")
# p adjacent_words?("rake", "rbke")
# p adjacent_words?("house", "hous")

wordchain = WordChainer.new("./dictionary.txt")

p wordchain.run("market", "waiter")
p wordchain.run("duck", "ruby")