require_relative 'card'

module CardDeck
  class Deck < Array
    # Fisher-Yates shuffle adapted from:
    #   https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_modern_algorithm
    #
    # the shuffle is deterministic and repeatable when an RNG seed is provided
    def shuffle(rng_seed = nil)
      rng = shuffle_rng(rng_seed)
      len = length

      (0..(len-2)).each do |i|
        j = rng.rand(i...len)

        tmp = cards[i]
        cards[i] = cards[j]
        cards[j] = tmp
      end
    end

    def shuffle_rng(rng_seed = nil)
      if rng_seed.nil?
        Random.new
      else
        unless rng_seed.is_a? Integer
          rng_seed = rng_seed.to_i
        end
        Random.new(rng_seed)
      end
    end

    def to_s
      "[#{cards.join(', ')}]"
    end

    def inspect
      "#<Deck: #{to_s}>"
    end
  end
end
