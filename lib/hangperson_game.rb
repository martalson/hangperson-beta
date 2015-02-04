class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = "-" * new_word.length
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    if not letter or letter.length == 0 or /[^a-zA-Z]/.match(letter)
        raise ArgumentError
    elsif @guesses.include?(letter) or @wrong_guesses.include?(letter)
        return false
    elsif @word.include?(letter) and !@guesses.include?(letter)
        @guesses += letter
        return true
    elsif !@word.include?(letter) and !@wrong_guesses.include?(letter)
        @wrong_guesses += letter
        return true
    end
   end

   def word_with_guesses
       display = ""
       for i in 0...@word.length
        print i
         if @guesses.include?(@word[i])
            display += @word[i]
         else
            display += "-"
         end
       end
       return display 
   end
   def check_win_or_lose
       if word_with_guesses == @word
          return :win 
       elsif @wrong_guesses.length >= 7
          return :lose
       end
       return :play
   end
end
