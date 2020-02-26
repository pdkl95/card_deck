require_relative 'card'

module CardDeck
  class Deck < Array
    def self.create(type = :standard)
      new.tap do |d|
        case type
        when :empty
          # do nothing
        when :standard
          d.add_cards CardDeck::Card::STANDARD
        end
      end
    end

    def add_cards(card_list)
      card_list.each do |c|
        self.push(c)
      end
    end

    # Fisher-Yates shuffle adapted from:
    #   https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_modern_algorithm
    #
    # the shuffle is deterministic and repeatable when an RNG seed is provided
    def shuffle!(rng_seed = nil)
      rng = shuffle_rng(rng_seed)
      len = length

      (0..(len-2)).each do |i|
        j = rng.rand(i...len)

        tmp = self[i]
        self[i] = self[j]
        self[j] = tmp
      end
      self
    end

    def shuffle(rng_seed = nil)
      dup.shuffle!(rng_seed)
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

    def to_s(opt = {})
      if opt[:split]
        split_len = case opt[:split]
                    when Integer
                      opt[:split]
                    when :auto
                      [length / 4, 13].max
                    end
        joiner = opt[:joiner] || ', '
        prefix = opt[:prefix] || ''
        suffix = opt[:suffix] || ''
        split_joiner = opt[:split_joiner] || ",\n"

        slices = each_slice(split_len).map do |group|
          group.join(joiner)
        end

        [prefix, slices.join(split_joiner), suffix].join('')
      else
        joiner = opt[:joiner] || ', '
        prefix = opt[:prefix] || '['
        suffix = opt[:suffix] || ']'

        [prefix, join(joiner), suffix].join('')
      end
    end

    def to_s_small_rows(opt = {})
      default_opt = {
        split: :auto,
        joiner: ' ',
        split_joiner: "\n"
      }
      to_s(default_opt.merge(opt))
    end

    def inspect
      "#<Deck: #{to_s}>"
    end
  end
end
