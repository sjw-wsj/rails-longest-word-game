require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]


   is_in_grid = included?(@word.upcase, @letters)
   is_english = english_word?(@word)
   p is_english
   p is_in_grid
    p @word
    p @letters
   if !is_in_grid
    @answer = "Sorry but #{@word} cant be built"
  elsif is_in_grid && !is_english
    @answer = "Sorry but #{@word} does not seem to be a valid English word..."
  else
    @answer = "Congratulations! #{@word}  is a valid English word!"
  end


  end


  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
