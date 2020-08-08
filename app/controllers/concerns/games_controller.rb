
class GamesController < ApplicationController

require "open-uri"
  def new
    @letters = []
     i = 0
     while i < 11
        randomer = ('a'..'z').to_a[rand(26)]
        @letters << randomer
        i = i+1
     end
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @english_word = english_word?(word)
    @included = included?(@word, @letters)
  end

  private

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}", 'r')
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(word, letters)
    word.chars.all?{|letter| word.count(letter) <= letters.count(letter) }
  end
end
