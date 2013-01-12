
desc "Start the stream of tweets"
task "stream_tweets" => :environment do
  BrandGauge::TwitterStream.new.consume 
end

