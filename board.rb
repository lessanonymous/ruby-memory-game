require_relative "card"

class Board
    
    def initialize

        @grid = Array.new(4) { Array.new(4) }
        @matched_cards = []

    end

    def [](position)

        row, col = position
        @grid[row][col]

    end

    def []=(position, value)

        row, col = position
        @grid[row][col] = value 

    end

    def all_grid_positions

        positions = []
        @grid.each_index do | row_idx |

            @grid[row_idx].each_index { | col_idx | positions << [row_idx, col_idx] }

        end
        positions

    end

    def random_face_value(possible_face_values)

        face_value = possible_face_values.sample
        possible_face_values.delete(face_value)

    end

    def place_face_value_pair(possible_face_values, positions)

        face_value = random_face_value(possible_face_values)
        2.times do

            position = positions.sample
            self[position] = Card.new(face_value)
            positions.delete(position)

        end

    end

    def populate

        possible_face_values = (:A..:Z).to_a
        positions = self.all_grid_positions
        until positions.empty?

            self.place_face_value_pair(possible_face_values, positions)

        end

    end

    def render

        system("clear")
        puts "  0 1 2 3"
        @grid.each_with_index do | row, idx |

            print_line = "#{idx}"
            row.each do | card |

                print_line += " #{card.display_face_value}"

            end
            puts print_line

        end

    end

    def won?

        @grid.flatten.none? { | card | card.display_face_value == "*" }

    end

    def reveal(guessed_position)

        card = self[guessed_position]
        if card.display_face_value == "*"

            card.reveal 
            card.display_face_value

        end

    end

    def hide(guessed_position)

        card = self[guessed_position]
        unless card.display_face_value == "*"

            card.hide

        end

    end

    def receive_match(position1, position2)

        [position1, position2].each { | pos | @matched_cards << pos }

    end

    def get_all_positions

        all_positions = []
        (0...@grid.length).each do | row |

            (0...@grid.length).each { | col | all_positions << [row, col] }

        end
        all_positions

    end

    def get_valid_positions

        all_positions = self.get_all_positions
        
        all_positions.reject do | position |
           
            @matched_cards.any? { | matched_card | matched_card == position }

        end

    end

end