class Rating < ActiveRecord::Base

validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }
belongs_to :beer
belongs_to :user
  attr_accessible :beer_id, :score, :user_id
  
  scope :recent, order(:created_at).limit(5)
  
  def to_s
  	return beer.name + " " + score.to_s
  end
end
