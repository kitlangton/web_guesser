require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@remaining_guesses = 5
@@should_reset = false

get '/' do

  reset_game if @@should_reset
  @@should_reset = false

  guess = params["guess"]
  cheatmode = params["cheat"] == 'true'

  message, status = check_guess(guess)
  unless status == :empty
    @@remaining_guesses -= 1
  end

  if @@remaining_guesses == 0
    @@should_reset = true
    @@remaining_guesses = 5
    message = "You're out of guesses! Resetting the number and starting again"
  end

  if status == :correct
    @@should_reset = true
    @@remaining_guesses = 5
    message = "You got it! Resetting the number and starting again"
  end


  erb :index, locals: { secret_number: @@secret_number, message: message, status: status, cheatmode: cheatmode}

end

def reset_game
    @@secret_number = rand(101)
    @@remaining_guesses = 5
end

def check_guess(guess)
  return ["Enter a guess!", :empty] if guess == ""
  guess = guess.to_i

  if guess - 5 > @@secret_number
    message = "Way too high!"
    value = :wayhigh
  elsif guess > @@secret_number
    message ="Too high!"
    value = :high
  elsif guess + 5 < @@secret_number
    message ="Way too low!"
    value = :waylow
  elsif guess < @@secret_number
    message ="Too low!"
    value = :low
  elsif guess == @@secret_number
    message = "You got it!"
    value = :correct
  end

  [message, value]
end
