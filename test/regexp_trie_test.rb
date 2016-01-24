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
    re = RegexpTrie.union("foo", "foobar", "foobaz")
    assert { re === "foo" }
    assert { re === "foobar" }
    assert { re === "foobaz" }
    assert { !(re === "bar") }
    assert { !(re === "baz") }
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

  def test_union_rx
    assert { RegexpTrie.union('a') == /a/ }
    assert { RegexpTrie.union('a', 'aa') == /aa?/ }
    assert { RegexpTrie.union('a', 'b') == /[ab]/ }
    assert { RegexpTrie.union('foo', 'bar') == /(?:foo|bar)/ }
    assert { RegexpTrie.union('foo', 'bar', 'baz') == /(?:foo|ba[rz])/ }
  end

  def test_union_empty
    assert { RegexpTrie.union == Regexp.union }
  end

  def test_instance
    rt = RegexpTrie.new.add("foo").add("bar").add("baz")
    assert { rt.to_regexp == %r/(?:foo|ba[rz])/ }
  end
end
