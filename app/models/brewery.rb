class Brewery < ActiveRecord::Base

include Average

validates :name, presence: true
#validates_with YearValidator
validates :year, numericality: { greater_than_or_equal_to: 1042, only_integer: true }

has_many :beers, :dependent => :destroy
has_many :ratings, :through => :beers
  attr_accessible :name, :year
  
  def restart
  	self.year = 2014
  	puts "changed to year #{year}"
  end
  
  def to_s
  	return name
  end
end

class YearValidator < ActiveModel::Validator
	def year_cant_be_in_future(record)
  	if(Date.today.year > year)
  		record.errors[:year] << "Year can't be in the future!"
  	end
  end
end
