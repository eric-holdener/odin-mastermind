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
    code = generate_code
    puts 'The computer has generated a code! Time for you to guess it.'
    get_guess(code)
  end

  private

  # determines who in game is guessing, and who is creating the code. 
  # 1 for player guessing, computer code
  # 2 for player code, computer guessing
  def determine_guesser
    puts 'Would you like to guess, or create the code for the computer to guess?'
    puts '1 for guess, 2 for code'
    decision = gets.to_i
    unless decision.is_a? Integer
      puts "Looks like you didn't enter a number! Try again."
      determine_guesser
    end
    unless decision.between?(1, 2)
      puts 'Please enter either one or two!'
      determine_guesser
    end
    decision
  end

  def generate_code
    if @guesser == 1
      code = @computer.create_code
    else
      code = @player.create_code
    end
  end

  def get_guess(code)
    if @guesser == 1
      guess = @player.guess(code)
      puts "Guess = #{guess}"
    else 
      # code for the computer to guess (not currently implemented)
    end
  end
end

# class for human player instance to be called in game
class Player
  def initialize
    # code
  end

  def guess(code)
    puts 'Enter a number 1-6'
    num = gets
    num = num.to_i
    unless num.between?(1, 6)
      puts 'Looks like you entered an invalid entry! Please try again'
      game.get_guess(code)
    end
    num
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

  # randomly creates code, with repeats (potentially add option for no repeats later)
  def create_code()
    code = Array.new(3)
    code.each_with_index do |code_letter, idx|
      code[idx] = rand(1..6)
    end
    code
  end
end

game = Game.new
game.create_game
