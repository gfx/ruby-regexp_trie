require 'test_helper'

class RegexpTrieTest < Minitest::Test
  def regexp
    RegexpTrie.union("foo", "bar", "baz")
  end

  def test_that_it_has_a_version_number
    refute_nil ::RegexpTrie::VERSION
  end

  def test_union
    assert { regexp === "foo" }
    assert { regexp === "bar" }
    assert { regexp === "baz" }
  end

  def test_instance
    rt = RegexpTrie.new.add("foo").add("bar").add("baz")
    assert { rt.to_regexp == %r/(?:foo|ba[rz])/ }
  end
end
