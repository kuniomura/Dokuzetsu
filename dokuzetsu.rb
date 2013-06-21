# -*- encoding: utf-8 -*-  #for 1.9 later UTF-8/CP932/EUC-JP etc
require 'nkf'

$lines = []

def textfilter(line)
  line.chomp!
  line = NKF.nkf('-w', line)
  line.gsub!(/^[ ]+開く/, "")
  line.gsub!(/^[ ]+返信/, "")
  line.gsub!(/^[ ]+リツイート/, "")
  line.gsub!(/^[ ]+お気に入りに登録/, "")

  if line.size > 0 && /プログラムを勉強している人の毒舌な妹/ !~ line then
    line.gsub!(/    /, "")
    $lines << line
    puts line
  end
end

while ARGV[0] =~ /^-/
  ARGV.shift
end

ARGF.each {|line| textfilter(line)}

puts $lines.size().to_s
$lines = $lines.sort.uniq
$lines.each do |line|
  puts line
end
puts "wite " + $lines.size().to_s
