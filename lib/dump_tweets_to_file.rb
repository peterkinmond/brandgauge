output = File.open(File.expand_path("~/Desktop/brandgauge_tweets_03-12-2012.txt"), "w")

number_of_tweets = RawTweet.count

NUMBER_PER_PAGE = 1000

puts "Beginning to index tweets"

index = 0
while(index < number_of_tweets)
  puts "archiving tweets: #{index} - #{index + NUMBER_PER_PAGE}"
  RawTweet.order("id ASC").limit(NUMBER_PER_PAGE).offset(index).each do |tweet|
    output.write("#{tweet.content}\n")
  end
  output.flush
  index += NUMBER_PER_PAGE
end

output.close

puts "All Done"
