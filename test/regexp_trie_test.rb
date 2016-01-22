require 'test_helper'

class RegexpTrieTest < Minitest::Test

  def test_version_number
    refute_nil ::RegexpTrie::VERSION
  end

  def test_union
    re = RegexpTrie.union("foo", "bar", "baz")
    assert { re === "foo" }
    assert { re === "bar" }
    assert { re === "baz" }
    assert { !(re === "FOO") }
  end

  def test_union_ignorecase
    re = RegexpTrie.union("foo", "bar", "baz", option: Regexp::IGNORECASE)
    assert { re === 'foo' }
    assert { re === 'FOO' }
  end

  def test_instance
    rt = RegexpTrie.new.add("foo").add("bar").add("baz")
    assert { rt.to_regexp == %r/(?:foo|ba[rz])/ }
  end
end
