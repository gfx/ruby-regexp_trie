# RegexpTrie

## Synopsis

```ruby
require 'regexp_trie'
rt = RegexpTrie.new;
rt.add_all(*%w(foobar fooxar foozap fooza/))
puts $rt.to_regexp # (?-xism:foo(?:bar|xar|zap?))
```

See also the original [Regexp::Trie in Perl](https://metacpan.org/pod/Regexp::Trie).

## Description

RegexpTrie takes an arbitrary number of regular expressions and assembles them into a single regular expression (or RE) that matches all that the individual REs match.

In other words, this library provides a limited but optimized version of `Regexp.union()`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regexp_trie'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gfx/regexp_trie.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
