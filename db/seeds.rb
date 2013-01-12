# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
AdminUser.destroy_all
AdminUser.create!(:email => "admin@brandgauge.com", :password => "secret")

Brand.destroy_all
brand1 = Brand.create!(:name => "JC Penny")
brand2 = Brand.create!(:name => "Klout")

User.destroy_all
User.create!(:email => "advertiser@jcpenney.com", :password => "secret", :brand => brand1)
User.create!(:email => "advertiser@klout.com", :password => "secret", :brand => brand2)

Campaign.destroy_all
Campaign.create!(:keyphrase => "Ellen 2012", :brand => brand1)
Campaign.create!(:keyphrase => "JCP for the win", :brand => brand1)
Campaign.create!(:keyphrase => "Mad for March", :brand => brand1)

Campaign.create!(:keyphrase => "Klout for Animals", :brand => brand2)
