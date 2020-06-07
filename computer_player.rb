class ComputerPlayer

    attr_writer :previous_guess
    
    def initialize

        @known_cards = {}
        @previous_guess = nil

    end

    def receive_revealed_card(position, face_value)

        @known_cards[position] = face_value

    end

    def get_other_match_position(valid_positions)

        pos, _ = @known_cards.find do | position, face_value |
           
            @previous_guess != position && @known_cards[@previous_guess] == face_value && valid_positions.include?(position)

        end
        pos

    end

    def first_guess(valid_positions)

        self.get_match_position(valid_positions) || self.get_unknown_position(valid_positions) 

    end

    def second_guess(valid_positions)

        self.get_other_match_position(valid_positions) || self.get_unknown_position(valid_positions) 

    end

    def get_position(valid_positions)

        if @previous_guess

            self.second_guess(valid_positions)

        else

            self.first_guess(valid_positions)

        end

    end

    def get_match_position(valid_positions)

        pos, _ = @known_cards.find do | position1, face_value1 |
            
            @known_cards.any? do | position2, face_value2 |
               
                position1 != position2 && face_value1 == face_value2 && valid_positions.include?(position1)

            end

        end
        pos

    end

    def get_unknown_position(valid_positions)

        unknown_positions = valid_positions.reject do | valid_position |

            @known_cards.any? do | known_position, known_face_value |

                known_position == valid_position

            end

        end
        unknown_positions.sample

    end

end