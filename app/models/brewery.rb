class Brewery < ActiveRecord::Base
has_many :beers
  attr_accessible :name, :year
end
