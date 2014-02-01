class Beer < ActiveRecord::Base

include Average

validates :name, presence: true

belongs_to :brewery
has_many :ratings, :dependent => :destroy
has_many :users, through: :ratings

  attr_accessible :brewery_id, :name, :style
  
  def to_s
  	return brewery.name + " " + name
  end
  
end
