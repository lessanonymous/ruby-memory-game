class Card

    attr_reader :face_value
    
    def initialize(face_value)

        @face_value = face_value
        @face_up = false

    end

    def display_face_value

        @face_up ? @face_value : "*"

    end

    def hide

        @face_up = false 

    end

    def reveal

        @face_up = true

    end

    def ==(other_card)

        self.face_value == other_card.face_value

    end

end