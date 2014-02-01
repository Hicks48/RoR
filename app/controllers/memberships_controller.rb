class MembershipsController < ApplicationController
	def new
		if(current_user.nil?)
  			redirect_to 'signin'
  		end
		@membership = Membership.new
		@beer_clubs = BeerClub.all
		render :join
	end
	
	def create
		@membership = Membership.new(params[:membership])
		@membership.user_id = current_user.id
		if @membership.save
			redirect_to user_path(current_user)
		else
			@beer_clubs = BeerClub.all
			render :join
		end
	end
end