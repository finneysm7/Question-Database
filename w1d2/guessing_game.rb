#!/usr/bin/env ruby

def guessing_game
  win = false
  computer_choice = rand(0..100)
  counter = 0
  
  while win == false
    guess = gets_input
    win = evaluator(guess, computer_choice)
    counter+=1
  end
  puts "You got it!\nYou took #{counter} guesses to win."
  
end

def gets_input
  puts "Please guess a number between 0 and 100!"
  user_input = gets.chomp!
  Integer(user_input)
end

def evaluator(guess, computer_choice)
  if guess > computer_choice
    puts "too high"
  elsif guess < computer_choice
    puts "too low"
  else
    return true
  end
  
  false
end

