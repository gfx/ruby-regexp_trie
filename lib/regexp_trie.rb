# frozen_string_literal: true

require_relative "regexp_trie/version"

class RegexpTrie

  # @param [Array<String>] strings Set of patterns
  # @param [Fixnum,Boolean] option The second argument of Regexp.new()
  # @return [Regexp]
  def self.union(*strings, option: nil)
    new(*strings).to_regexp(option)
  end

  def initialize(*strings)
    @head = {}

    strings.flatten.each do |str|
      add(str)
    end
  end

  # @param [String] str
  def add(str)
    return self if !str || str.empty?

    entry = @head
    str.each_char do |c|
      entry[c] ||= {}
      entry = entry[c]
    end
    entry[:end] = nil
    self
  end

  # @return [String]
  def to_source
    if @head.empty?
      Regexp.union.source
    else
      build(@head)
    end
  end

  # @return [Regexp]
  def to_regexp(option = nil)
    Regexp.new(to_source, option)
  end

  private

  def build(entry)
    return nil if entry.include?(:end) && entry.size == 1

    alt = []
    cc = []
    q = false

    entry.keys.each do |c|
      if entry[c]
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
        "(?:#{result})?"
      end
    else
      result
    end
  end
end
