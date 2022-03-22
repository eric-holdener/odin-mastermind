require 'pry-byebug'

# class to create and play the game
class Game
  def initialize
    @player = Player.new
    @computer = Computer.new
    @guesser = ''
    @player_guess = []
    @computer_guess = []
    @code = []
    @rounds = 0
    @results = []
    @comparison = []
  end

  def create_game
    @guesser = determine_guesser
    @code = generate_code
    play_game
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
    else
      unless decision.between?(1, 2)
        puts 'Please enter either one or two!'
        determine_guesser
      else
        decision
      end
    end
  end

  def generate_code
    if @guesser == 1
      @code = @computer.create_code
    else
      @code = @player.create_code
    end
  end

  def get_guess
    if @guesser == 1
      @player.guess
      @player_guess = @player.guess_num
    else 
      # code for the computer to guess (not currently implemented)
      puts 'The computer will now try to guess your code'
      @computer_guess = @computer.create_code
      puts "The computer guessed #{@computer_guess}."
    end
  end

  def play_game
    if @player_guess == @code || @computer_guess == @code
      puts "Congratulations! You guessed the code in #{@rounds} guesses!"
      puts "The code was #{@code}"
    elsif @rounds >= 12
      puts 'You did not guess the code :('
      puts "The code was #{@code}"
    else
      @rounds += 1
      get_guess
      compare_guess_code
      puts "Here are the results from the guess: #{@results}"
      puts 'Black means one of the guesses was the right number in the right spot.'
      puts 'White means one of the guess was the right number in the wrong spot.'
      play_game
    end
  end

  def compare_guess_code
    @results = []
    @comparison = []
    @comparison.append(@code)
    @comparison = @comparison.flatten
    @comparison_guess = []
    i = 0
    if @guesser == 1
      @comparison_guess.append(@player_guess)
      @comparison_guess = @comparison_guess.flatten
      @player_guess.each do |num|
        if @comparison_guess[i] == @comparison[i]
          @results.push("Black")
          @comparison.delete_at(i)
          @comparison_guess.delete_at(i)
          unless i == 0
            i -= 1
          end
        elsif @comparison.include? @comparison_guess[i]
          @results.push("White")
          temp_idx = @comparison.find_index(@comparison_guess[i])
          @comparison.delete_at(temp_idx)
          @comparison_guess.delete_at(i)
          unless i == 0
            i -= 1
          end
        else
          i += 1
        end
      end
      puts "Your guess was #{@player_guess}"
    else
      @comparison_guess.append(@computer_guess)
      @comparison_guess = @comparison_guess.flatten
      @computer_guess.each do |num|
        if @comparison_guess[i] == @comparison[i]
          @results.push("Black")
          @comparison.delete_at(i)
          @comparison_guess.delete_at(i)
          unless i == 0
            i -= 1
          end
        elsif @comparison.include? @comparison_guess[i]
          @results.push("White")
          temp_idx = @comparison.find_index(@comparison_guess[i])
          @comparison.delete_at(temp_idx)
          @comparison_guess.delete_at(i)
          unless i == 0
            i -= 1
          end
        else
          i += 1
        end
      end
    end
  end
end

# class for human player instance to be called in game
class Player
  attr_accessor :guess_num, :code

  def initialize
    # code
    @guess_num = []
    @code = []
  end

  def guess
    puts 'Enter a 4 number combination, any number between 1 and 6'
    num = gets.chomp
    num = num.split('')
    num.each_with_index do |number, idx|
      num[idx] = number.to_i
    end
    if num.length > 4 || num.length < 4
      puts 'Looks like you guessed too many numbers!'
    else
      check_array = num.select { |n| n.between?(1, 6) }
      unless check_array.length == num.length
        puts 'Looks like you entered an invalid entry! Please try again'
        guess
      else
        @guess_num = num
      end
    end
  end

  def create_code()
    puts 'Enter a 4 number combination, any number between 1 and 6'
    num = gets.chomp
    num = num.split('')
    num.each_with_index do |number, idx|
      num[idx] = number.to_i
    end
    if num.length > 4
      puts 'Looks like you entered too many numbers for the code!'
    else
      check_array = num.select { |n| n.between?(1, 6) }
      unless check_array.length == num.length
        puts 'Looks like you entered an invalid entry! Please try again'
        guess
      else
        @code = num
      end
    end
  end
end

# class for computer player instance to be created in game
class Computer
  # randomly creates code, with repeats (potentially add option for no repeats later)
  def create_code()
    code = Array.new(4)
    code.each_with_index do |code_letter, idx|
      code[idx] = rand(1..6)
    end
    code
  end
end

game = Game.new
game.create_game
