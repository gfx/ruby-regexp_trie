require 'test_helper'

class RegexpTrieTest < Minitest::Test
  def regexp
    RegexpTrie.new.add_all("foo", "bar", "baz").to_regexp
  end

  def test_that_it_has_a_version_number
    refute_nil ::RegexpTrie::VERSION
  end

  def test_trie
    assert { regexp === "foo" }
    assert { regexp === "bar" }
    assert { regexp === "baz" }
  end
end
