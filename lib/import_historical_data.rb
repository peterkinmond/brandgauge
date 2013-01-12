f = File.open(Rails.root.join("historical_data", ARGV[0]), "r")

enricher = BrandGauge::Jobs::EnrichTweet.new
tweets = 0

f.each do |line|
  tweets += 1
  puts "importing tweet: #{tweets}"
  historical_tweet = JSON.parse(line)
  raw_tweet = {
    "id_str" => historical_tweet["id_str"],
    "text" => historical_tweet["text"],
    "user" => {
      "id_str" => historical_tweet["from_user_id_str"],
      "screen_name" => historical_tweet["from_user"],
      "name" => historical_tweet["from_user_name"],
      "location" => "",
      "followers_count" => 0,
      "profile_image_url" => historical_tweet["profile_image_url"]
    },
    "created_at" => historical_tweet["created_at"]
  }

  enricher.perform(raw_tweet)
end
