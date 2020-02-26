#!/bin/env ruby

#############################################################################
#                                                                           #
# A demonstration of Kruskal Count Card Trick, as seen here:                #
#   http://faculty.uml.edu/rmontenegro/research/kruskal_count/kruskal.html  #
#                                                                           #
# Original Script Author: pdkl95 (2018)                                     #
# License: This script is placed into the public domain.                    #
#                                                                           #
#############################################################################

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "card_deck"


deck = CardDeck.create_deck(:standard)

# reduce the facecard values to make the trick wort more reliably with one deck
deck.each do |c|
  case c.name
  when 'jack', 'queen', 'king'
    c.value = 5
  end
end

def card_after(deck, index)
  next_index = index + deck[index].value

  if next_index < deck.length
    next_index
  else
    nil
  end
end

def chain_from(deck, index)
  next_index = card_after(deck, index)
  head = [index]

  if next_index
    head + chain_from(deck, next_index)
  else
    head
  end
end

def index_to_s(deck, index)
  card = "#{deck[index]}".rjust(3)
  "(#{index}, #{card})"
end

def chain_to_s(deck, chain)
  chain.map do |index|
    index_to_s(deck, index)
  end.join(" -> ")
end

def chain_str_from(deck, start)
  chain_to_s(deck, chain_from(deck, start))
end

def print_chain(deck, start)
  puts chain_str_from(deck, start)
end

# right-justify output to align the matching chain ends
def rjust_strings(list)
  noansi_list = list.map do |str|
    # strip ANSI codes before computing the length
    str.gsub(/\e(\[(\d+;)*(\d+)?m|\([a-zA-Z])/, '')
  end

  max_len = noansi_list.map do |str|
    str.length 
  end.max  
  
  list.map.with_index do |str, idx|
    noansi_str = noansi_list[idx]
    padlen = max_len - noansi_str.length
    pad = ' ' * padlen
    pad + str
  end
end

def show_deck_chains(range, deck)
  puts "Deck:"
  puts deck.to_s_small_rows(prefix: "\t", split_joiner: "\n\t")
  puts

  heads = range.map(&:to_s)

  chains = range.map do |start|
    chain_str_from(deck, start)
  end

  jheads  = rjust_strings(heads)
  jchains = rjust_strings(chains)

  jheads.zip(jchains).each do |pair|
    puts pair.join(': ')
  end
end


########################################################################
# main()

range = (0..9)

if ARGV.length > 0
  first = true
  ARGV.each do |seed|
    if first
      first = false
    else
      puts
    end
    puts "RNG seed: #{seed}"
    show_deck_chains(range, deck.shuffle(seed))
  end
else
  show_deck_chains(range, deck.shuffle)
end
