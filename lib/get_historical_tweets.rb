require 'twitter'
require 'yajl/json_gem'

f = File.open(ARGV[1], "w")

puts "getting page 1 of tweets"

page = 1
tweets = Twitter.search(ARGV[0], :rpp => 100, :page => page)

while tweets.length > 0
  tweets.each do |tweet|
    f.write("#{JSON.dump(tweet.attrs)}\n")
  end
  page += 1
  puts "getting page #{page} of tweets"
  tweets = Twitter.search(ARGV[0], :rpp => 100, :page => page)
end

f.flush
f.close
