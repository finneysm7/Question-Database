class Code
  attr_accessor :correct_count, :choices, :code
  
  def initialize
    @choices = [:r, :g, :b, :y, :o, :p]
    @code = []
  end
  
  def self.random
    computer_choice = Code.new
    choices_arr = []
    4.times { choices_arr << computer_choice.choices.sample }
    computer_choice.code = choices_arr
  end
  
  def self.parse(input)
    user_input = Code.new
    array_input = input.split("").map { |char| char.to_sym }
    
    # Fix these later
    raise ArgumentError, "incorrect number of arguments" unless array_input.size == 4
    raise ArgumentError, "These colors don't exist" unless array_input.all? do |input_color|
      user_input.choices.include?(input_color)
    end
    user_input.code = array_input
    user_input
  end
  
  def exact_matches(other_code)
    @correct_count = 0
    other_code.each_index do |index|
      @correct_count += 1 if other_code[index] == self.code[index]
    end
    @correct_count
  end
  
  def near_matches(other_code)
    near_count = 0
    other_code.each_with_index do |color, index|
      near_count += 1 if self.code.include?(color) && other_code[index] != self.code[index]
    end
    near_count
  end
   
  def won?
    self.correct_count == 4
  end
  
end

class Game 
  def play   
    @guesses = 0
    
    computer_choice = Code.random
    human_choice = Code.parse(get_user_input)
    
    until human_choice.won? || @guesses == 9
      @guesses += 1
      #Could make this a render function
      puts "Exact matches: #{ human_choice.exact_matches(computer_choice) }"
      puts "Near matches: #{ human_choice.near_matches(computer_choice) }"
      puts "You've used #{ @guesses } so far"
      
      human_choice = Code.parse(get_user_input) unless human_choice.won?
    end
    #Could also probably be a render function
    puts "Congratulations! You won" if human_choice.won?
    puts "You lose! Nice try" if @guesses == 9
     
  end
  
  def get_user_input
    puts "Please make your guess"
    gets.chomp
  end
end
