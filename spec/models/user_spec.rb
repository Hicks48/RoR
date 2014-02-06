require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
  
  # Ensimmainen tehtava
  it "User with too short password is not saved" do
  	user = User.create username:"Robert", password:"Ro3", password_confirmation:"Ro3"
  	
  	expect(user).not_to be_valid
  	expect(User.count).to eq(0)
  end
  
  #Ensimmainen tehtava
  it "User with password containing only letters is not saved" do
  	user = User.create username:"Robert", password:"DowneyJR", password_confirmation:"DowneyJR"
  	
  	expect(user).not_to be_valid
  	expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  
  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
    
     it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end
    
    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end
  end
  
  def create_beer_with_rating(score, user)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
	end
	
	def create_beers_with_ratings(*scores, user)
  		scores.each do |score|
    	create_beer_with_rating(score, user)
  end
end
	#Kolmas tehtava
	describe "favorite style" do
		let(:user){FactoryGirl.create(:user)}
	
		it "has method for determining one" do
			user.should respond_to :favorite_style
		end
		
		it "without ratings does not have one" do
      		expect(user.favorite_style).to eq(nil)
    	end
    	
    	it "is the only rated if only one rating" do
    		style = "IPA"
    		give_user_rating(user, style, 10)
    		
    		expect(user.favorite_style).to eq(style)
    	end
    	
    	it "is the one with higest average score" do
    		style_1 = "Lager"
    		style_2 = "IPA"
    		style_3 = "Porter"
    		
    		give_user_rating(user, style_1, 5)
    		give_user_rating(user, style_2, 15)
    		give_user_rating(user, style_3, 10)
    		
    		expect(user.favorite_style).to eq(style_2)
    	end
	end
	
	def give_user_rating(user, style, score)
		beer = FactoryGirl.create(:beer, style: style)
		FactoryGirl.create(:rating, score: score, beer: beer, user: user)
	end
	
	#Neljas tehtava
	describe "favorite brewery" do
		let(:user){FactoryGirl.create(:user)}
		
		it "has method for determining one" do
			user.should respond_to :favorite_brewery
		end
		
		it "without ratings does not have one" do
      		expect(user.favorite_brewery).to eq(nil)
    	end
    	
    	it "is the only rated if only one rating" do
    		brew = give_user_brewery_rating(user, "Testi_brew", 10)
    		
    		expect(user.favorite_brewery).to eq(brew)
    	end
    	
    	it "is the one with higest average score" do
    		brew_1 = give_user_brewery_rating(user, "Testi_brew_1", 5)
    		brew_2 = give_user_brewery_rating(user, "Testi_brew_2", 15)
    		brew_3 = give_user_brewery_rating(user, "Testi_brew_3", 10)
    		
    		expect(user.favorite_brewery).to eq(brew_2)
    	end
	end
	
	def give_user_brewery_rating(user, brewery_name, score)
		brewery = FactoryGirl.create(:brewery, name: brewery_name)
		beer = FactoryGirl.create(:beer, brewery: brewery)
		
		FactoryGirl.create(:rating, score: score, beer: beer, user: user)
		return brewery
	end
end
