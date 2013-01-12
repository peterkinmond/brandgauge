require 'spec_helper'

describe BrandGauge::KloutCalculator do
  let(:fake_klout_response) do
    {"status" => 200, 
      "users" => [{"twitter_screen_name"=>"jasontorres", "kscore"=>29.89}]} 
  end
  let(:fake_klout_client) { double(Klout::API, :klout => fake_klout_response) }

  before do
    Klout::API.stub(:new => fake_klout_client)
  end

  describe "#retreive" do

    it "should set the klout score" do
      subject.retreive("jasontorres").should == 29.89
    end

    it "should cache the response so we don't hit klout api to much" do
      subject.retreive("jasontorres")
      Rails.cache.fetch("Klout:jasontorres").should == 29.89
    end

    it "should catch any excpetions and return 0 for score" do
      fake_klout_client.stub(:klout).and_raise("foobar")
      subject.retreive("jasontorres")
    end
  end
  
end
