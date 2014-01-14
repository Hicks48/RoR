class Beer < ActiveRecord::Base
belongs_to :brewery
  attr_accessible :brewery_id, :name, :style
end
