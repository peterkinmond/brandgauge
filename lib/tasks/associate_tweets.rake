desc "Start the stream of tweets"
task "associate_tweets" => :environment do
  brands = Brand.all
  brands.each do |brand| 
    puts "updating tweets for brand: #{brand.name}"
    brand.associate_tweets
    brand.campaigns.each do |campaign|
      puts "\tupdating tweets for campaign #{campaign.keyphrase}"
      campaign.associate_tweets
    end
  end
end
