class HumanPlayer

    attr_writer :previous_guess

    def initialize

        @known_cards = {}
        @previous_guess = nil

    end

    def receive_revealed_card(position, face_value)

        @known_cards[position] = face_value

    end

    def get_position(valid_positions)

        puts "choose a position on the board using the following format '1 3'"
        input = gets.chomp
        position = input.split(" ").map(&:to_i)

    end

end