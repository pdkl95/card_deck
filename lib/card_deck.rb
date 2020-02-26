require "card_deck/version"

module CardDeck
  class Error < StandardError; end

  def self.global_bool_opt(name, default_value, &setup)
    ivar = "@use_#{name}"

    define_singleton_method("use_#{name}?") do
      unless instance_variable_defined? ivar
        send "enable_#{name}!"
      end
      instance_variable_get ivar
    end

    define_singleton_method("enable_#{name}!") do
      if setup
        instance_variable_set ivar, setup.call
      else
        instance_variable_set ivar, true
      end
    end

    define_singleton_method("disable_#{name}!") do
      instance_variable_set ivar, false
    end
  end

  global_bool_opt 'utf8', true

  def self.tput
    @tput ||= {}
  end

  global_bool_opt 'color', true do
    rv = false
    begin
      { black: ['setab 7', 'setaf 0'],
        red:   ['setab 7', 'setaf 1'],
        clear: ['sgr0']
      }.each_pair do |op, caps|
        tput[op] = IO.popen(['tput', '-S'], "r+") do |cmd|
          caps.each do |cap|
            cmd.puts(cap)            
          end
          cmd.close_write
          cmd.gets
        end
      end
      rv = true
    end
    rv
  end

  def self.colorize_string(str, color)
    return str unless use_color?

    [ tput[color], str, tput[:clear] ].join('')
  end
end

require "card_deck/suit"
require "card_deck/face"
require "card_deck/card"
require "card_deck/deck"

module CardDeck
  def self.create_deck(type = :standard)
    CardDeck::Deck.create(type)
  end
end

