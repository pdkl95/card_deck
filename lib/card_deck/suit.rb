module CardDeck
  class Suit
    attr_reader :ascii_symbol, :name, :color, :rank

    def initialize(_ascii_symbol, _utf8_symbol, _name, _color, _rank)
      @ascii_symbol = _ascii_symbol
      @utf8_symbol  = _utf8_symbol
      @name  = _name
      @color = _color
      @rank  = _rank

      if @utf8_symbol.is_a? Integer
        @utf8_symbol = @utf8_symbol.chr(Encoding::UTF_8)
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
      "#<Suit #{ascii_symbol} #{name.inspect} #{color.inspect}>"
    end

    def to_i
      rank
    end

    STANDARD = [
      new('D', 0x2666, 'diamonds', :red,   1),
      new('C', 0x2660, 'clubs',    :black, 2),
      new('H', 0x2665, 'hearts',   :red,   3),
      new('S', 0x2663, 'spades',   :black, 4)
    ]
  end
end
