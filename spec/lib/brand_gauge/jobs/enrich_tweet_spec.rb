require 'spec_helper'

describe BrandGauge::Jobs::EnrichTweet do
  let(:fake_raw_tweet) { File.read(Rails.root.join("spec", "fixtures", "tweet.json")) }
  let(:fake_tweet) { JSON.parse(fake_raw_tweet) }
  let(:fake_klout_calculator) { double(BrandGauge::KloutCalculator, :retreive => nil) }
  
  before do
    Klout::API.stub(:new => fake_klout_calculator)
    BrandGauge::KloutCalculator.stub(:new => fake_klout_calculator)
  end

  describe ".perform" do
    before do
      BrandGauge::Jobs::EnrichTweet.stub(:new => double().as_null_object)
    end
    it "should retreive and parse the raw tweet" do
      RawTweet.should_receive(:find).with(1).and_return(double(:content => "fake raw tweet"))
      JSON.should_receive(:parse) do |txt|
        txt.should == "fake raw tweet"
      end
      BrandGauge::Jobs::EnrichTweet.perform(1)
    end
  end

  describe "#perform" do
    before do
      RawTweet.stub(:find => double(:content => "fake raw tweet"))
      JSON.stub(:parse => fake_tweet)
      subject.stub(:store_processed_tweet)
    end


    context "tweet is not a retweet" do
      it "should call method to add the klout score" do
        subject.should_receive(:add_klout_score)
        subject.perform(fake_tweet)
      end

      it "should call method to add sentiment" do
        subject.should_receive(:add_sentiment)
        subject.perform(fake_tweet)
      end

      it "should store the processes and enriched tweet" do
        subject.should_receive(:store_processed_tweet)
        subject.perform(fake_tweet)
      end
    end

    context "tweet is a retweet" do
      it "should increment the retweet count of an existing tweet" do
        fake_tweet["retweeted"] = true
        subject.should_receive(:increment_retweet_count)
        subject.perform(fake_tweet)
      end
    end
  end

  describe "#add_klout_score" do
    it 'should use the klout calculator to add klout to the tweet' do
      fake_klout_calculator.should_receive(:retreive).with(fake_tweet["user"]["screen_name"])
      subject.instance_variable_set(:@tweet, fake_tweet)
      subject.add_klout_score
    end
  end

  describe "#increment_retweet_count" do
    it "should increment the retweeted count on an existing tweet" do
      subject.instance_variable_set(:@tweet, fake_tweet)
      fake_existing_tweet = double(Tweet)
      fake_existing_tweet.should_receive(:increment).with(:retweet_count)
      Tweet.should_receive(:where).and_return([fake_existing_tweet])
      subject.increment_retweet_count
    end
  end

  describe "#store_processed_tweet" do
    before do
      subject.instance_variable_set(:@tweet, fake_tweet)
      Campaign.stub(:all => [])
      Brand.stub(:all => [])
    end

    it "should store a new tweet in the db" do
      expect { subject.store_processed_tweet }.to change{ Tweet.count }.by(1)
    end

    it "should raise an exception if the tweet is invalid" do
      fake_tweet["text"] = nil
      subject.instance_variable_set(:@tweet, fake_tweet)
      lambda { subject.store_processed_tweet }.should raise_error
    end

    it "should attempt to associate the tweet" do
      subject.should_receive(:associate_tweet)
      subject.store_processed_tweet
    end
  end

  describe "#associate_tweet" do
    let(:fake_campaign) { double(Campaign, :associate_tweet => nil) }
    let(:fake_brand) { double(Brand, :associate_tweet => nil) }
    before do
      Campaign.stub(:all => [fake_campaign])
      Brand.stub(:all => [fake_brand])
    end

    it "should attempt to associate the new tweet to all known campaigns" do
      fake_campaign.should_receive(:associate_tweet).with("fake tweet")
      subject.associate_tweet("fake tweet")
    end

    it "should attempt to associate tweet to all known brands" do
      fake_brand.should_receive(:associate_tweet).with("fake tweet")
      subject.associate_tweet("fake tweet")
    end
  end
end
