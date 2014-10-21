class Hangman
  def self.human_v_human
    Hangman.new(HumanPlayer.new, HumanPlayer.new).play
  end
  
  def self.human_v_computer
    Hangman.new(HumanPlayer.new, ComputerPlayer.new).play
  end
  
  def self.computer_v_computer
    Hangman.new(ComputerPlayer.new, ComputerPlayer.new).play
  end
  
  def self.computer_v_human
    Hangman.new(ComputerPlayer.new, HumanPlayer.new).play
  end
  
  def initialize(guessing_player, checking_player)
    @guesser = guessing_player
    @checker = checking_player
    
    @game_name = "#{guessing_player} vs. #{checking_player}"
  end

  def play
    @checker.receive_secret_length
    @secret_word = @checker.pick_secret_word
    won = false
    counter = 1
    until won
      @checker.check_guess(@guesser.guess) 
      won = @checker.handle_guess_response
      puts "Counter = #{ counter }"
      counter += 1
    end
  end
end

class ComputerPlayer
  attr_accessor :output_array

  def initialize
    @name = "HAL 2000"
  end

  def pick_secret_word
    dict = []
    File.foreach("./dictionary.txt") do |line|
      dict << line.chomp
    end
    @secret_word = dict.sample
    self.output_array = Array.new(@secret_word.length) { "_ " }
  end

  def receive_secret_length
    puts "Please give secret word length:"
    @secret_length = gets.chomp.to_i
  end

  def guess
    guess = ("a".."z").to_a.sample
    puts "Computer chooses: #{guess}"
    guess
  end

  def narrow_dictionary(dictionary)
    

  def 

  def check_guess(letter)
    secret_word_arr = @secret_word.split("")
  
    secret_word_arr.each_with_index do |char, index|
      if char == letter
        self.output_array[index] = char
      end
    end     
  end

  def handle_guess_response
    puts "Secret word: #{ self.output_array.join("") }"
    if self.output_array == @secret_word.split("")
      puts "You won!"
      return true
    end
    false
  end
  
end


class HumanPlayer
  attr_accessor :human_guess, :output_array
  
  def initialize
    @name = "Dave"
  end

  def pick_secret_word
    self.output_array = Array.new(@secret_length) { "_ " }
  end
  
  def receive_secret_length
    puts "How long is the word?"
    @secret_length = gets.chomp.to_i
  end

  def guess
    puts "Please enter your guess:"
    human_guess = gets.chomp
  end

  def check_guess(letter) 
    puts "What positions is that letter in?"
    correct_indexes = gets.chomp.split(" ")
    return if correct_indexes.nil?
  
    correct_indexes.each do |index|
      self.output_array[index.to_i] = letter
    end
    puts "Output_array = #{ self.output_array.join("") }"
    self.output_array
  end

  def handle_guess_response
    if self.output_array.none? { |letter| letter == "_ " }
      puts "Guesser won!"
      return true
    end
    false
  end

end



