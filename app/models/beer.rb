class Beer < ActiveRecord::Base

include Average

belongs_to :brewery
has_many :ratings, :dependent => :destroy
  attr_accessible :brewery_id, :name, :style
  
  def to_s
  	return brewery.name + " " + name
  end
  
end
