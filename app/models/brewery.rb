class Brewery < ActiveRecord::Base

include Average

has_many :beers, :dependent => :destroy
has_many :ratings, :through => :beers
  attr_accessible :name, :year
  
  def to_s
  	return name
  end
end
