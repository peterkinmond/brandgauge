require 'spec_helper'

describe Tweet do
  describe "validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :tweet_id }
    it { should validate_presence_of :user_screen_name }
    it { should validate_presence_of :user_real_name }
    it { should validate_presence_of :user_profile_image_url }
    it { should validate_presence_of :followers_count }
    it { should validate_presence_of :tweeted_at }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :followers_count }
  end
end
