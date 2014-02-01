class BeerClub < ActiveRecord::Base
	has_many :memberships, :dependent => :destroy
	has_many :users, through: :memberships

  attr_accessible :city, :founded, :name
  
  def to_s
  	return name
  end
end
