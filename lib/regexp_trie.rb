require_relative "regexp_trie/version"

class RegexpTrie

  # @param [Array<String>] strings
  # @return [Regexp]
  def self.union(*strings)
    rt = new
    strings.flatten.each do |arg|
      rt.add(arg)
    end
    rt.to_regexp
  end

  def initialize
    @head = {}
  end

  # @param [String] pattern
  def add(str)
    return self unless str && str.size > 0

    entry = @head
    str.each_char do |c|
      entry[c] ||= {}
      entry = entry[c]
    end
    entry[''] = true # terminator
    self
  end

  # @return [Regexp]
  def to_regexp
    if @head.empty?
      Regexp.union
    else
      Regexp.new(build(@head))
    end
  end

  private

  def build(entry)
    return nil if entry[''] && entry.size == 1

    alt = []
    cc = []
    q = false

    entry.keys.each do |c|
      if entry[c].kind_of?(Hash)
        recurse = build(entry[c])
        qc = Regexp.quote(c)
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
