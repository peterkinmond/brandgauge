f = File.open(ARGV[0])

sc = BrandGauge::SentimentCalculator.new

lines = 0
s_lines = 0

f.each do |line|
  lines += 1
  tweet = JSON.parse(line)
  next unless tweet["iso_language_code"] == "en"
  sentiment = sc.analyze(tweet["text"])
  if sentiment != 0
    s_lines += 1
    puts "Tweet: #{tweet["text"]} has sentiment #{sentiment}" 
  end
end

puts "total lines = #{lines}"
puts "lines with sentiment = #{s_lines}"

puts "#{(s_lines.to_f / lines.to_f) * 100} % of tweets had sentiment"
