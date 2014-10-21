def rps(user_choice)
  comp_choice = randomizer
  return comp_choice + ", " + result(user_choice, comp_choice)
end

def result(user_choice, comp_choice)
  return "Draw" if user_choice == comp_choice
  user_rock(comp_choice) if user_choice == "Rock"
  user_paper(comp_choice) if user_choice == "Paper"
  user_scissors(comp_choice) if user_choice == "Scissors"
end

def randomizer
  ["Rock", "Paper", "Scissors"].sample
end

def user_rock(comp_choice)
  return "Win" if comp_choice == "Scissors"
  return "Lose"
end

def user_paper(comp_choice)
  return "Win" if comp_choice == "Rock"
  return "Lose"
end

def user_scissors(comp_choice)
  return "Win" if comp_choice == "Paper"
  return "Lose"
end