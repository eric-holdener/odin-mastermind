require 'pry-byebug'

# class to create and play the game
class Game
  def initialize
    @player = Player.new
    @computer = Computer.new
    @guesser = ''
  end

  def create_game
    @guesser = determine_guesser
    puts @guesser
  end

  private

  # determines who in game is guessing, and who is creating the code. 
  # 1 for player guessing, computer code
  # 2 for player code, computer guessing
  def determine_guesser
    puts 'Would you like to guess, or create the code for the computer to guess?'
    puts '1 for guess, 2 for code'
    begin
      decision = gets.to_i
    rescue
      puts "Looks like you didn't enter a number! Try again."
      determine_guesser
    else
      unless decision.between?(1, 2)
        puts 'Please enter either one or two!'
        determine_guesser
      end
    end
    decision
  end
end

# class for human player instance to be called in game
class Player
  def initialize
    # code
  end

  def guess()
    # code
  end

  def create_code()
    # code
  end
end

# class for computer player instance to be created in game
class Computer
  def initialize
    # code
  end

  def create_code()
    # code
  end
end

game = Game.new
game.create_game
