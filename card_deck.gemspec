require_relative 'lib/card_deck/version'

Gem::Specification.new do |spec|
  spec.name          = "card_deck"
  spec.version       = CardDeck::VERSION
  spec.authors       = ["Brent Sanders"]
  #spec.email         = ["git@thoughtnoise.net"]

  spec.summary       = %q{Deck-of-Cards classes}
  spec.description   = %q{A set of classes that implement the common features of standard decks of playing cards.}
  spec.homepage      = "https://github.com/pdkl95/card_deck"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  #spec.bindir        = "exe"
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
