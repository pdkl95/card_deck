module CardDeck
  class Face
    include Comparable

    attr_reader :symbol, :name, :value, :order

    def initialize(_symbol, _name, _value = _symbol.to_i, _order = _value)
      @symbol = _symbol
      @name   = _name
      @value  = _value
      @order  = _order
    end

    def <=>(other)
      self.order <=> other.order
    end

    def to_i
      value
    end

    def to_s
      symbol
    end

    def inspect
      "#<Face #{symbol} #{name.inspect} value=#{value}>"
    end

    STANDARD = [
      new('A', 'ace', 1),

      new('2', 'two'),
      new('3', 'three'),
      new('4', 'four'),
      new('5', 'five'),
      new('6', 'six'),
      new('7', 'seven'),
      new('8', 'eight'),
      new('9', 'nine'),

      new('T', 'ten', 10),

      new('J', 'jack',  10, 11),
      new('Q', 'queen', 10, 12),
      new('K', 'king',  10, 13)
    ]
  end
end
