# coding: utf-8
# frozen_string_literal: true

require_relative './lib/regexp_trie/version'

Gem::Specification.new do |spec|
  spec.name          = "regexp_trie"
  spec.version       = RegexpTrie::VERSION
  spec.authors       = ["FUJI Goro (gfx)"]
  spec.email         = ["gfuji@cpan.org"]

  spec.summary       = %q{Optimized Regexp builder with Trie}
  spec.description   = %q{Optimized Regexp builder with Trie as a port of Perl's Regexp::Trie}
  spec.homepage      = "https://github.com/gfx/ruby-regexp_trie"
  spec.license       = "MIT"
  spec.metadata = {
    "source_code_uri" => "https://github.com/gfx/ruby-regexp_trie",
    "allowed_push_host" => "https://rubygems.org/"
  }


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.11"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "minitest", ">= 5.0"
  spec.add_development_dependency "minitest-power_assert"
  spec.add_development_dependency "simplecov"
end
