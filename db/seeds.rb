# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

b1.beers.create name:"Iso 3", style:"Lager"
b1.beers.create name:"Karhu", style:"Lager"
b1.beers.create name:"Tuplahumala", style:"Lager"
b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
b2.beers.create name:"X Porter", style:"Porter"
b3.beers.create name:"Hefezeizen", style:"Weizen"
b3.beers.create name:"Helles", style:"Lager"

user1 = User.create username:"user_1", password:"User123"
user2 = User.create username:"user_2", password:"User456"

ber1 = Beer.find_by_name("Iso 3")
ber2 = Beer.find_by_name("X Porter")
ber3 = Beer.find_by_name("Helles")
ber4 = Beer.find_by_name("Tuplahumala")

ber1.ratings.create(score:10, user_id:user1.id)
ber1.ratings.create(score:8, user_id:user1.id)
ber2.ratings.create(score:4, user_id:user1.id)
ber2.ratings.create(score:7, user_id:user1.id)
ber3.ratings.create(score:14, user_id:user2.id)
ber3.ratings.create(score:18, user_id:user2.id)
ber4.ratings.create(score:5, user_id:user2.id)
ber4.ratings.create(score:6, user_id:user2.id)
