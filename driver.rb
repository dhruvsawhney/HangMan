require_relative 'hang_man.rb'

class Driver

  def printInstructions
    puts %q{Please select an option:
      1. Press '1' at anytime to save the game
      2. Enter a letter to play the game
      3. Enter '0' to quit the game at any time
    }
  end

  def cleanSavedFile
    h = HangMan.new
    h.to_serialize
  end

  def main
    # create an instance of HangMan class
    h = HangMan.new

    # For the first run
    puts "Enter 'd' to load previous game or 'n' to load new game"

    while true
      input = gets.chomp
      if input == 'd' || input == 'n'
        break
      else
        puts "Invalid input: please try again"
      end
    end

    if input == 'd'
      h = h.to_deserialize
      printInstructions
      puts "From last time ...\n"
      h.to_s
    end

    if input == 'n'
      puts "Starting new game ...\n"
      sleep(2)
      printInstructions
      h.to_s
    end

    # main user-interaction loop
    loop do
      # clean previous game as well
      if h.getCount == 0
        cleanSavedFile
        puts "You lost!"
        return
      end

      input = gets.chomp
      # check for letter or word guess
      if input.match(/[a-z]+|[A-Z]+/)
        input = input.downcase
        if input.length > 1
          word_status = h.checkWord(input)
          h.to_s
          if word_status
            cleanSavedFile
            puts "YOU WON!"
            break
          end
        else
          char_status = h.letterGuess(input)
          h.to_s
          if char_status
            cleanSavedFile
            puts "YOU WON!"
            break
          end
        end

      elsif input == '1'
        puts "Game saved!\n"
        h.to_serialize

      elsif input == "0"
        puts "Thanks for playing!\n"
        sleep(1)
        exit

      else
        puts "Invalid input: please try again\n"
      end
    end
  end

end

d = Driver.new
d.main
