require 'yaml'

class HangMan
  attr_reader :comp_guess, :user_guess, :count, :guess, :misses
  # Initialize the structures used for the game
  def initialize
    f = File.open("data.txt").readlines
    @comp_guess = cleanGuess(f)
    @user_guess = Array.new(@comp_guess.size, nil)
    @count = 9
    @guess = Array.new
    @misses = Array.new
  end

  # make the guess from the .txt file and clean the additional whitespace
  # at end of the word chosen
  def cleanGuess(f)
    r = Random.new
    index = r.rand(0...f.length)
    comp_guess = f[index]
    comp_guess = comp_guess.rstrip!
    # length requirement for word chosen
    while comp_guess.length < 5 || comp_guess.length > 12
      index = r.rand(0...f.length)
      comp_guess = f[index]
      comp_guess = comp_guess.rstrip!
    end
    comp_guess = comp_guess.downcase
    return comp_guess
  end

  # Print the game to screen
  def to_s
    word = "Word: "
    guess = "Guess: "
    misses = "Misses: "
    count = "#{@count} tries left"
    @user_guess.each {|i| i.nil? ? word += '_ ' : word += i}
    @guess.each {|i| !i.nil? ? guess += "#{i} " : guess += ""}
    @misses.each {|i| !i.nil? ? misses += "#{i} " : misses += ""}
    puts count
    puts word
    puts guess
    puts misses
    puts "\n"
  end

  # A letter based guess for Hangman
  def letterGuess(c)
    present = false
    chars = @comp_guess.split("")
    chars.each_index do |index|
      if chars[index] == c
        present = true
        @user_guess[index] = c
      end
    end
    present ? @guess.push(c) : @misses.push(c)
    @count -= 1
    return isOver
  end

  # Check if all the letters have been correctly guesses
  def isOver
    @user_guess.each do |i|
      if i == nil
        return false
      end
    end
    return true
  end

  # Additional functionality to check the word
  def checkWord(w)
    @count -= 1
    if w == @comp_guess
      chars = w.split("")
      chars.each_index do |i|
        @user_guess[i] = chars[i]
      end
      @guess.push(w)
      return true
    end
    @misses.push(w)
    return false
  end

  # Getter for the remaining tries
  def getCount
    return @count
  end

  # serialize the game
  def to_serialize
    File.open("output.yml", "w") {|f| f.write(self.to_yaml)}
  end

  # to deserialize the game
  def to_deserialize
    YAML.load (File.open('output.yml'))
  end

end
