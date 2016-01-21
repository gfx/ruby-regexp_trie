require_relative "regexp_trie/version"

class RegexpTrie

  def initialize
    @head = {}
  end

  # @param [String] str
  def add(str)
    return self unless str && str.size > 0

    entry = @head
    str.chars.each do |c|
      entry[c] ||= {}
      entry = entry[c]
    end
    entry[''] = true # terminator
    self
  end

  # @param [Enumerable] args
  def add_all(*args)
    args.each do |arg|
      add(arg)
    end
    self
  end

  # @return [Regexp]
  def to_regexp
    Regexp.new(_build(@head))
  end

  def _build(entry)
    return nil if entry[''] && entry.size == 1

    alt = []
    cc = []
    q = false

    entry.keys.sort.each do |c|
      qc = Regexp.quote(c)
      if entry[c].kind_of?(Hash)
        recurse = _build(entry[c])
        if recurse
          alt.push(qc + recurse)
        else
          cc.push(qc)
        end
      else
        q = true
      end
    end

    cconly = alt.empty?
    unless cc.empty?
      alt.push(cc.size == 1 ? cc.first : "[#{cc.join('')}]")
    end

    result = alt.size == 1 ? alt.first : "(?:#{alt.join('|')})"
    if q
      if cconly
        "#{result}?"
      else
        "(?:#{$result})?"
      end
    else
      result
    end
  end
end
