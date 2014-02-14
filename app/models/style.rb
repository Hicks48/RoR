class Style < ActiveRecord::Base
has_many :beers
  attr_accessible :description, :name
  
  def to_s
  	return name
  end
end
