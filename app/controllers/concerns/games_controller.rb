
require "open-uri"

class GamesController < ApplicationController
VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @english_word = english_word?(@word)
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
