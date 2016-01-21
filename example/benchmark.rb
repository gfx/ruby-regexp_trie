require 'benchmark'
require 'regexp_trie'

keywords = []

File.open('example/hatena-keyword-list.csv', 'r:UTF-8') do |io|
  io.each do |line|
    yomi, word = line.split(/\t/)
    keywords.push(word.strip)
  end
end

puts "build regexp ..."

rx_raw = Regexp.new("(?:#{keywords.map { |w| Regexp.escape(w) }.join('|')})")
rx_trie = RegexpTrie.new.add_all(keywords).to_regexp

puts "rx_raw:  #{rx_raw.to_s.length}"
puts "rx_trie: #{rx_trie.to_s.length}"

text = <<'EOS'
http://blog.livedoor.jp/dankogai/archives/50074802.html

TRIE-Optimized Regexp  [Show on Hatena Bookmark]
これをPerlで直接使えたらうれしいよね＞おおる

きまぐれ日記: はてなキーワードを高速に付与
そこで、はてなキーワードを TRIE を使って付与するプログラムを作ってみました。
というわけで、やってみました。


最初はDartsのXSを作ろうとしたのだけど、どうもtemplateばりばりのC++コードとXSは相性が悪い。でもTrieを作るだけなら、Perlでもそこそこ出来るし、実際Regexp::OptimizerやRegexp::Assembleのようなモジュールもある。ただこれらはTrie以外のOptimizeもしてしまうので、ちょっと重たいというわけで、mk_trie_regexp.plというScriptをサクっと書いてみました。

使い方は簡単。/usr/share/dict/wordsのような、一行一語のファイルを引数に指定すると、それに対応した正規表現を吐いてくれます。あとはそれを

my $re = do "keyword.list.rx";
とかして読み込めばOK。

しかし、はてなのキーワードリストはすでにRegexpとして書かれちゃっているので、これを戻す為にhatena2list.plというscriptも書いときました。

そしてベンチマークを取った結果が以下です。

PowerBook G4 1.67MHz / Mac OS X v10.4
            (warning: too few iterations for a reliable count)
          s/iter  comp_raw comp_trie
comp_raw    4.61        --      -87%
comp_trie  0.592      679%        --
           Rate  pm_raw pm_trie
pm_raw    156/s      --   -100%
pm_trie 70337/s  44874%      --
            (warning: too few iterations for a reliable count)
          s/iter  nm_raw nm_trie
nm_raw      23.6      --   -100%
nm_trie 1.57e-02 150763%      --
Dual Xeon 2.66MHz / FreeBSD 5.4-Stable
            (warning: too few iterations for a reliable count)
          s/iter  comp_raw comp_trie
comp_raw    4.45        --      -90%
comp_trie  0.465      855%        --
           Rate  pm_raw pm_trie
pm_raw    532/s      --    -99%
pm_trie 92027/s  17197%      --
            (warning: too few iterations for a reliable count)
          s/iter  nm_raw nm_trie
nm_raw      6.91      --   -100%
nm_trie 1.22e-02  56417%      --
Darts版ほどとは行きませんが、なかなかPracticalなのではないでしょうか。なんといってもPerlから直接使える--正規表現そのものはRubyでも互換?--のはぐ～でしょう。

Dan the Just Another (Perl|Trie) Hacker
EOS

unless text.gsub(rx_raw, 'XXX') == text.gsub(rx_trie, 'XXX')
  puts 'Not good!'
end

Benchmark.bm 20 do |r|
  r.report "Regexp raw" do
    text.gsub(rx_raw, 'XXX')
  end
  r.report "RegexpTrie" do
    text.gsub(rx_trie, 'XXX')
  end
end
