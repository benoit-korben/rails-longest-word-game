require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    # raise
    @letters = params[:letters].split('')
    @answer = params[:answer]

    url = "https://dictionary.lewagon.com/"
    @english = JSON.parse(URI.open("#{url}#{@answer}").read)["found"]

    @answer.chars().all? do |char|
      if @letters.include?(char)
        @letters.delete_at(@letters.index(char))  # Remove the character
        @chartest = true
      else
        @chartest = false
      end
    end

    @result = "The word is valid according to the grid and is an English word ✅" if @chartest && @english
    @result = " The word is valid according to the grid, but is not a valid English word ❌" if @chartest && !@english
    @result = "The word can’t be built out of the original grid ❌" if !@chartest

  end
end
