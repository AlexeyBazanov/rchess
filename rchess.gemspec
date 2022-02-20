# frozen_string_literal: true

require_relative "lib/rchess/version"

Gem::Specification.new do |spec|
  spec.name          = "rchess"
  spec.version       = Rchess::VERSION
  spec.authors       = ["Alex"]
  spec.email         = ["alexey.bazanov13@gmail.com"]

  spec.summary       = "Ruby chess engine."
  spec.description   = "OOP based ruby chess engine that implements the basic rules of chess and FEN notation."
  spec.homepage      = "https://github.com/AlexeyBazanov/rchess.git"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/AlexeyBazanov/rchess.git"
  spec.metadata["changelog_uri"] = "https://github.com/AlexeyBazanov/rchess.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  # end
  spec.files = Dir['lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "zeitwerk", ">= 2.5.4"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
