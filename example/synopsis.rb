#!/usr/bin/env ruby
require 'regexp_trie'
# like Regexp.union()
p RegexpTrie.union(%w(foobar fooxar foozap fooza)) # /foo(?:bar|xar|zap?)/

# or object-oriented interface
rt = RegexpTrie.new
%w(foobar fooxar foozap fooza).each do |word|
  rt.add(word)
end
p rt.to_regexp # /foo(?:bar|xar|zap?)/
