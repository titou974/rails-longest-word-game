require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @result = ""
    @attempt = params[:word].downcase.split('')
    @grid = params[:grid].downcase.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    if @attempt.any? { |letter| !@grid.include?(letter) }
      @result = "Sorry, it can't be built out of this letters : #{@grid.join('').upcase}"
    elsif @attempt.any? { |letter| @grid.include?(letter) } && !user["found"]
      @result = "Sorry but #{@attempt.join} is not a valid word"
    else
      @result = "Congratulations!"
    end
  end
end
