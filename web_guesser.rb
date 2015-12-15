require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(101)

get '/' do

  guess = params["guess"]

  message = check_guess(guess)

  erb :index, locals: { secret_number: settings.secret_number, message: message}
end

def check_guess(guess)
  return "Enter a guess!" if guess == ""
  guess = guess.to_i

  if guess - 5 > settings.secret_number
    "Way too high!"
  elsif guess > settings.secret_number
    "Too high!"
  elsif guess + 5 < settings.secret_number
    "Way too low!"
  elsif guess < settings.secret_number
    "Too low!"
  elsif guess == settings.secret_number
    "You got it!\nThe SECRET NUMBER is #{settings.secret_number}"
  end
end
