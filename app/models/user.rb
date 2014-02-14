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
  attr_accessible :username, :password, :password_confirmation, :admin
  
  def favorite_beer
  	return nil if ratings.empty?
    return ratings.sort_by{ |r| r.score }.last.beer
  end
  
  #Kolmas tehtava
  #def favorite_style
  #	return nil if ratings.empty?
  #	styles=[]
  #	init_styles(styles)
  #	max = nil
  #	max_score = 0.0
  #	ratings.each do |r|
  #		if(!styles.include?(r.beer.style))
  #			if(max.nil? || max_score < average_style(r.beer.style))
  #				max = r.beer.style
  #				max_score = average_style(max)
  #			end
  #		end
  #	end
  #	return max
  #end
  
  #def init_styles(styles)
  #	beers.each do |b|
  #		if(styles.include?(b.style))
  #			styles << b.style
  #		end
  #	end
  #end
  
  #def average_style(style)
  #	sum = 0.0
  #	count = 0.0
  #	ratings.each do |r|
  #		if(r.beer.style == style)
  #			sum = sum + r.score
  #			count = count + 1
  #		end
  #	end 	
  #	return (sum / count)
  #end
  
  def favorite_brewery
    favorite :brewery
  end

  def favorite_style
    favorite :style
  end
  
  def favorite_color
    favorite :color
  end

  private

  def rated_styles
    ratings.map{ |r| r.beer.style }.uniq
  end

  def style_average(style)
    ratings_of_style = ratings.select{ |r| r.beer.style==style }
    ratings_of_style.inject(0.0){ |sum, r| sum+r.score}/ratings_of_style.count
  end

  def rated_breweries
    ratings.map{ |r| r.beer.brewery}.uniq
  end

  def brewery_average(brewery)
    ratings_of_brewery = ratings.select{ |r| r.beer.brewery==brewery }
    ratings_of_brewery.inject(0.0){ |sum, r| sum+r.score}/ratings_of_brewery.count
  end
  
  def rated(category)
    ratings.map{ |r| r.beer.send(category) }.uniq
  end
  
  def rating_average(category, item)
    ratings_of_item = ratings.select{ |r|r.beer.send(category)==item }
    return 0 if ratings_of_item.empty?
    ratings_of_item.inject(0.0){ |sum ,r| sum+r.score } / ratings_of_item.count
  end
  
  def favorite(category)
    return nil if ratings.empty?
    rating_pairs = rated(category).inject([]) do |pairs, item|
      pairs << [item, rating_average(category, item)]
    end
    rating_pairs.sort_by { |s| s.last }.last.first
  end

  
  #Neljas tehtava
  #def favorite_brewery
  #	return nil if ratings.empty?
  #	brewerys = []
  #	init_brewerys(brewerys)
  #	max = nil
  #	max_score = 0.0
  #	ratings.each do |r|
  #		if(!brewerys.include?(r.beer.brewery))
  #			if(max.nil? || max_score < average_brewery(r.beer.brewery))
  #				max = r.beer.brewery
  #				max_score = average_brewery(r.beer.brewery)
  #			end
  #		end
  #	end
  #	return max
  #end
  
  #def init_brewerys(brewerys)
  #	beers.each do |b|
  #		if(brewerys.include?(b.brewery))
  #			brewerys << b.brewery
  #		end
  #	end
  #end
  
  #def average_brewery(brewery)
  #	sum = 0.0
  #	count = 0.0
  #	ratings.each do |r|
  #		if(r.beer.brewery == brewery)
  #			sum = sum + r.score
  #			count = count + 1
  #		end
  #	end
  #	return (sum / count)
  #end
end
