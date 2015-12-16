require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(101)

get '/' do

  guess = params["guess"]

  message, status = check_guess(guess)

  erb :index, locals: { secret_number: settings.secret_number, message: message, status: status}
end

def check_guess(guess)
  return ["Enter a guess!", :empty] if guess == ""
  guess = guess.to_i

  if guess - 5 > settings.secret_number
    message = "Way too high!"
    value = :wayhigh
  elsif guess > settings.secret_number
    message ="Too high!"
    value = :high
  elsif guess + 5 < settings.secret_number
    message ="Way too low!"
    value = :waylow
  elsif guess < settings.secret_number
    message ="Too low!"
    value = :low
  elsif guess == settings.secret_number
    message = "You got it!"
    value = :correct
  end

  [message, value]
end
