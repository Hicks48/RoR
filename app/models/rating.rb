class Rating < ActiveRecord::Base
belongs_to :beer
  attr_accessible :beer_id, :score
  
  def to_s
  	beer.name + " " + score.to_s
  end
end
