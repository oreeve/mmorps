require "sinatra"
require 'pry'
use Rack::Session::Cookie, {
  secret: "butter butter"
}

before do
  @choice = nil
end

get '/' do
  session[:player_score] = 0
  session[:comp_score] = 0

  erb :index
end

post '/' do
  @comp_choice = ['rock', 'paper', 'scissors'].sample

  if params[:choice] == 'rock' && @comp_choice == 'scissors'
    @result = 'Rock beats scissors! Player wins!'
    session[:player_score] += 1
    @choice = true
  elsif params[:choice] == 'rock' && @comp_choice == 'paper'
    @result = 'Paper beats rock! Computer wins!'
    session[:comp_score] += 1
    @choice = true
  elsif params[:choice] == 'scissors' && @comp_choice == 'rock'
    @result = 'Rock beats scissors! Computer wins!'
    session[:comp_score] += 1
    @choice = true
  elsif params[:choice] == 'scissors' && @comp_choice == 'paper'
    @result = 'Scissors beat paper! Player wins!'
    session[:player_score] += 1
    @choice = true
  elsif params[:choice] == 'paper' && @comp_choice == 'scissors'
    @result = 'Scissors beats paper! Computer wins!'
    session[:comp_score] += 1
    @choice = true
  elsif params[:choice] == 'paper' && @comp_choice == 'rock'
    @result = 'Paper beats rock! Player wins!'
    session[:player_score] += 1
    @choice = true
  elsif params[:choice] == @comp_choice
    @result = 'Tie!'
    @choice = true
  end

# binding.pry

  erb :index
end

post '/reset' do
  session.clear
  redirect '/'
end
