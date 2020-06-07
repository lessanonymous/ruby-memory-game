require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game
    
    def initialize(ai)

        @board = Board.new
        @previous_guess = nil
        @player = ai ? ComputerPlayer.new : HumanPlayer.new

    end

    def play

        @board.populate
        until self.game_over?

            @board.render
            puts
            valid_positions = @board.get_valid_positions
            position = nil 
            until valid_positions.include?(position) && position != @previous_guess

                @board.render 
                position = @player.get_position(valid_positions)

            end
            self.make_guess(position)

        end
        puts  
        puts "Congratulations, you won!"

    end

    def match?(position, previous_position)

        current_guess = @board[position]
        previous_guess = @board[@previous_guess]
        current_guess == previous_guess

    end

    def compare_guesses(position)

        if @previous_guess

            if self.match?(position, @previous_guess)

                puts
                puts "You got a match!" unless self.game_over?
                @board.receive_match(position, @previous_guess)
            else
                
                puts 
                puts "No match, try again"
                [position, @previous_guess].each { | pos | @board.hide(pos) }
                
            end
            @previous_guess = nil
            @player.previous_guess = nil

        else

            @previous_guess = position
            @player.previous_guess = position

        end

    end

    def make_guess(position)

        revealed_face_value = @board.reveal(position)
        @player.receive_revealed_card(position, revealed_face_value)
        @board.render 
        self.compare_guesses(position)
        sleep(2) unless self.game_over?
        @board.render

    end

    def game_over?

        @board.won?

    end

    

end

if __FILE__ == $PROGRAM_NAME

    ai = nil 
    while ai.nil?

        puts "Type 'hum' for human player and 'com' for computer player"
        input = gets.chomp
        if input == "hum"

            ai = false

        elsif input == "com"

            ai = true

        else

            puts "Invalid input"
            puts 

        end

    end
    game = Game.new(ai) 
    game.play   

end