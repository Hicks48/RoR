class Beer < ActiveRecord::Base

include Average

validates :name, presence: true
validates :style, presence: true

belongs_to :brewery
belongs_to :style
has_many :ratings, :dependent => :destroy
has_many :users, through: :ratings

  attr_accessible :brewery_id, :name, :old_style, :style, :style_id
  
  def to_s
  	return brewery.name + " " + name
  end
  
  def self.top(n)
   sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) } 
   return sorted_by_rating_in_desc_order.take(n)
  end
  
end
