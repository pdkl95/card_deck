require_relative 'suit'
require_relative 'face'

module CardDeck
  class Card
    attr_reader :ascii_symbol, :name, :color, :value, :order_by_suit, :order_by_face

    def initialize(opt = {})
      if opt[:suit] && opt[:face]
        raise ArgumentError, "When defining a card by :suit and :face, the list of all possible faces must be provided :all_faces" unless opt[:all_faces]
        raise ArgumentError, "When defining a card by :suit and :face, the list of all possible suits must be provided :all_suits" unless opt[:all_suits]

        @suit = opt[:suit]
        @face = opt[:face]

        @all_faces = opt[:all_faces]
        @all_suits = opt[:all_suits]

        @ascii_symbol = @suit.ascii_symbol + @face.symbol
        @utf8_symbol  = @suit.utf8_symbol  + @face.symbol

        @name  = "#{@face.name} of #{@suit.name}"
        @color = @suit.color
        @value = @face.value

        @order_by_suit = @face.order + (@all_faces.length * @suit.rank)
        @order_by_face = (@all_suits.length * @face.order) + @suit.rank
      else
        raise ArgumentError, "Cannot build Card from the given options: #{opt.inspect}"
      end
    end

    
    def utf8_symbol
      @utf8_symbol || @ascii_symbol
    end

    def symbol
      if CardDeck.use_utf8?
        utf8_symbol
      else
        ascii_symbol
      end
    end

    def to_s_nocolor
      symbol
    end

      def to_s_color
      CardDeck.colorize_string(symbol, color)
    end

    def to_s
      if CardDeck.use_color?
        to_s_color
      else
        to_s_nocolor
      end
    end

    def inspect
      "#<Card #{ascii_symbol} #{name.inspect} #{color.inspect} value=#{value}>"
    end

    STANDARD = CardDeck::Suit::STANDARD.product(CardDeck::Face::STANDARD).map do |x|
      suit, face = x
      new suit: suit, face: face,
          all_faces: CardDeck::Face::STANDARD,
          all_suits: CardDeck::Suit::STANDARD
    end
  end
end
