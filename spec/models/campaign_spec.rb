require 'spec_helper'

describe Campaign do
  subject { Campaign.new(:name => "fake campaign", :keyphrase => "foobar", :brand => Brand.new(:name => "test")) }

  let(:fake_brand) { Brand.create!(:name => "Fake Brand") }
  describe "validations" do
    it { should validate_presence_of(:brand_id) }
    it { should validate_presence_of(:name) }
  end

  describe "#associate_tweets" do
    it "sets the campaign id on all tweets that match campaign keyphrases" do
      Tweet.should_receive(:update_all) do |update, condition|
        condition.should == "content like '%test%' AND content like '%foobar%'"
      end
      subject.associate_tweets
    end
  end

  describe "#associate_tweet" do

    it 'sets the campaign id if the tweet content matches our brand and campaign' do
      tweet = double(Tweet, :content => "test foobar")
      tweet.should_receive(:update_attribute)
      subject.associate_tweet(tweet)
    end

    it "sets the campaign id and brand id if the tweet has our hastag" do
      campaign = Campaign.new(:id => 10, :hashtag => "#fake", :brand => Brand.new(:id => 1, :name => "test"))
      tweet = double(Tweet, :content => "#fake this is some other text")
      tweet.should_receive(:update_attributes)
      campaign.associate_tweet(tweet)
    end

    it 'should match case insensitive brand names' do
      tweet = double(Tweet, :content => "test @Foobar")
      tweet.should_receive(:update_attribute)
      subject.associate_tweet(tweet)
    end

    it "should not set campaign id if the tweet does not match our hastag" do
      campaign = Campaign.new(:id => 10, :hashtag => "#fake", :brand => Brand.new(:id => 1, :name => "test"))
      tweet = double(Tweet, :content => "fake this is some other text")
      tweet.should_not_receive(:update_attributes)
      campaign.associate_tweet(tweet)
    end

    it "does not set campaign id if the tweet does not match our campaign info" do
      tweet = double(Tweet, :content => "some other content")
      tweet.should_not_receive(:update_attribute)
      subject.associate_tweet(tweet)
    end
  end
end
