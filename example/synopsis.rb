require 'regexp_trie'
rt = RegexpTrie.new;
rt.add_all(*%w(foobar fooxar foozap fooza))
puts rt.to_regexp # (?-mix:foo(?:bar|xar|zap?))
