require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  
  #Tehtava kuusi
  it "Raitings page lists all raitings" do
  	create_ratings
  	visit ratings_path
  	
  	Rating.all.each do |r|
  		expect(page).to have_content(r.beer.name + " " + r.score.to_s)
  	end
  end
  
  it "Raintings page shows raintings count" do
  	create_ratings
  	visit ratings_path
  	
  	expect(page).to have_content("Number of ratings: " + Rating.count.to_s)
  end
  
  def create_ratings
  	FactoryGirl.create(:rating, user: user, beer: beer1, score: 10)
  	FactoryGirl.create(:rating, user: user, beer: beer1, score: 5)
  	FactoryGirl.create(:rating, user: user, beer: beer2, score: 20)
  	FactoryGirl.create(:rating, user: user, beer: beer2, score: 12)
  end
end
