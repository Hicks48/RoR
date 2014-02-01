class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :beer_club
	attr_accessible :beer_club_id, :user_id
	validates_uniqueness_of :user_id, scope: :beer_club_id, message: "Cant join same club more than once!"
end
