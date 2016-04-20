require 'test_helper'

class RegexpTrieTest < Minitest::Test

  def test_version_number
    refute_nil ::RegexpTrie::VERSION
  end

  def test_union_1
    re = RegexpTrie.union("foo", "bar", "baz")
    assert { re === "foo" }
    assert { re === "bar" }
    assert { re === "baz" }
    assert { !(re === "FOO") }
  end

  def test_union_2
    re = /\b#{RegexpTrie.union("foo", "foobar", "foobaz")}\b/
    assert { re === "foo" }
    assert { re === "foobar" }
    assert { re === "foobaz" }
    assert { re === "text foo text" }
    assert { re === "text foobar text" }
    assert { re === "text foobaz text" }
    assert { !(re === "bar") }
    assert { !(re === "baz") }
    assert { !(re === "text foobax text") }
  end

  def test_union_flatten
    re = RegexpTrie.union(["foo", "bar"], ["hoge", "fuga"])
    assert { re === "foo" }
    assert { re === "bar" }
    assert { re === "hoge" }
    assert { re === "fuga" }
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
