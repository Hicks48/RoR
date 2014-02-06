require 'spec_helper'

include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
  
  #Tehtava seitseman
  it "Only users own ratings are displayed on users own page" do
  	User.all.each do |u|
  		visit user_path(u)
  		Rating.all.each do |r|
  			if(r.user == u)
  				expect(page).to have_content(r.beer.name + " " + r.score.to_s)
  			else
  				expect(page).to have_no_content(r.beer.name + " " + r.score.to_s)
  			end
  		end
  	end
  end
  
  #Tehtava kahdeksan
  it "When user removes rating rating is removed from database" do
  	create_users_with_ratings
  	u = User.find_by_username "user_1"
  	init_rating_size = Rating.count
  	
  	sign_in(username: "user_1", password: "Foobar1")
  	visit user_path(u)
  	
  	first("li").click_link("delete")
  	expect(Rating.count).to eq(init_rating_size - 1)
  end
  
  #Tehtava yhdeksan
  it "Users own page contains favorite brewery and favorite style" do
  	user = User.find_by_username "Pekka"
  	sign_in(username:"Pekka", password:"Foobar1")
  	
  	brew_1 = FactoryGirl.create(:brewery, name: "Testi_Panimo_1")
  	brew_2 = FactoryGirl.create(:brewery, name: "Testi_Panimo_2")
  	
  	beer_1 = FactoryGirl.create(:beer, brewery: brew_1, name: "Testi_Kalja_1", style: "Paras")
  	beer_2 = FactoryGirl.create(:beer, brewery: brew_2,name: "Testi_Kalja_2", style: "Kohtalainen")
  	
  	FactoryGirl.create(:rating, user: user, beer: beer_1, score: 20)
  	FactoryGirl.create(:rating, user: user, beer: beer_2, score: 10)
  	
  	visit user_path(user)
  	
  	expect(page).to have_content("Favorite style: " + beer_1.style)
  	expect(page).to have_content("Favorite brewery: " + brew_1.to_s)
  end
  
  def create_users_with_ratings
  	user_1 = FactoryGirl.create(:user, username: "user_1")
  	user_2 = FactoryGirl.create(:user, username: "user_2")
  	
  	beer_1 = FactoryGirl.create(:beer, name: "beer_1")
  	beer_2 = FactoryGirl.create(:beer, name: "beer_2")
  	
  	FactoryGirl.create(:rating, user: user_1, beer: beer_1)
  	FactoryGirl.create(:rating, user: user_1, beer: beer_1)
  	
  	FactoryGirl.create(:rating, user: user_2, beer: beer_2)
  	FactoryGirl.create(:rating, user: user_2, beer: beer_2)
  end
end