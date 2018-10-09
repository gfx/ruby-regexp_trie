# RegexpTrie [![Build Status](https://travis-ci.org/gfx/ruby-regexp_trie.svg?branch=master)](https://travis-ci.org/gfx/ruby-regexp_trie) [![Gem Version](https://badge.fury.io/rb/regexp_trie.svg)](https://badge.fury.io/rb/regexp_trie)

## Synopsis

```ruby
#!/usr/bin/env ruby
require 'regexp_trie'

# like Regexp.union()
p RegexpTrie.union(%w(foobar fooxar foozap fooza)) # /foo(?:bar|xar|zap?)/
p RegexpTrie.union(%w(foobar fooxar foozap fooza), option: Regexp::IGNORECASE) # /foo(?:bar|xar|zap?)/i

# or object-oriented interface
rt = RegexpTrie.new
%w(foobar fooxar foozap fooza).each do |word|
  rt.add(word)
end
p rt.to_regexp # /foo(?:bar|xar|zap?)/
```

See also the original [Regexp::Trie in Perl](https://metacpan.org/pod/Regexp::Trie).

## Description

`RegexpTrie` takes an arbitrary number of regular expressions and assembles them into a single regular expression (or RE) that matches all that the individual REs match.

In other words, this library provides a limited but optimized version of `Regexp.union()`, even thouh there are some incompatibilities with it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regexp_trie'
```

## Incompatibilities with the built-in `Regexp.union()`

* `RegexpTrie` handles only literals. i.e. `RegexpTrie.union("foo.*bar")` produces `/foo\.\*bar/`, not `/foo.*bar/`
* `RegexpTrie` cannot handle empty strings.
* The order of words does not matter:
  * `Regexp.union("foo", "foobar").match("foobar") # => #<MatchData "foo">`
  * `RegexpTrie.union("foo", "foobar").match("foobar") # => #<MatchData "foobar">`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gfx/regexp_trie.

## See Also

* https://metacpan.org/pod/Regexp::Assemble
* https://metacpan.org/pod/Regexp::Trie

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

The original code is @dankogai's [Regexp::Trie](https://metacpan.org/pod/Regexp::Trie).
