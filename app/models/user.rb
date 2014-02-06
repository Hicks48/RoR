class User < ActiveRecord::Base
has_many :ratings, :dependent => :destroy
has_many :memberships, :dependent => :destroy
has_many :beers, through: :ratings
has_many :beer_clubs, through: :memberships

include Average

has_secure_password

validates :username, uniqueness: true
validates :username, length: { in: 3..15 }
validates :password, length: { minimum: 4 }
validates :password, format: { with: /(.*[A-Z].*[0-9].*)|(.*[0-9].*[A-Z].*)/ }
validates_confirmation_of :password
  attr_accessible :username, :password, :password_confirmation
  
  def favorite_beer
  	return nil if ratings.empty?
    return ratings.sort_by{ |r| r.score }.last.beer
  end
  #Kolmas tehtava
  def favorite_style
  	return nil if ratings.empty?
  	styles=[]
  	max = nil
  	max_score = 0.0
  	ratings.each do |r|
  		if(!styles.include?(r.beer.style))
  			if(max.nil? || max_score < average_style(r.beer.style))
  				max = r.beer.style
  				max_score = average_style(max)
  			end
  		end
  	end
  	return max
  end
  
  def average_style(style)
  	sum = 0.0
  	count = 0.0
  	ratings.each do |r|
  		if(r.beer.style == style)
  			sum = sum + r.score
  			count = count + 1
  		end
  	end 	
  	return (sum / count)
  end
  
  #Neljas tehtava
  def favorite_brewery
  	return nil if ratings.empty?
  	brewerys = []
  	max = nil
  	max_score = 0.0
  	ratings.each do |r|
  		if(!brewerys.include?(r.beer.brewery))
  			if(max.nil? || max_score < average_brewery(r.beer.brewery))
  				max = r.beer.brewery
  				max_score = average_brewery(r.beer.brewery)
  			end
  		end
  	end
  	return max
  end
  
  def average_brewery(brewery)
  	sum = 0.0
  	count = 0.0
  	ratings.each do |r|
  		if(r.beer.brewery == brewery)
  			sum = sum + r.score
  			count = count + 1
  		end
  	end
  	return (sum / count)
  end
end
