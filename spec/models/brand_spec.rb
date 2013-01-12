require 'spec_helper'

describe Brand do
  subject { Brand.new(:name => "foobar") }

  describe "validations" do
    it { should validate_presence_of :name }
    it { should have_many :users }
  end

  describe ".all_brand_names" do
    let(:brand_names) { ["fake 1", "fake 2"] }
    before do
      brand_names.each { |n| Brand.create!(:name => n) }
    end
    it "returns an array of all brand names" do
      Brand.all_brand_names.should == brand_names
    end
  end

  describe "#associate_tweets" do
    it "sets the campaign id on all tweets that match campaign keyphrases" do
      Tweet.should_receive(:update_all) do |update, condition|
        condition.should == "content like '%foobar%'"
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

    it "does not set campaign id if the tweet does not match our campaign info" do
      tweet = double(Tweet, :content => "some other content")

      tweet.should_not_receive(:update_attribute)
      subject.associate_tweet(tweet)
    end
  end
  
end
