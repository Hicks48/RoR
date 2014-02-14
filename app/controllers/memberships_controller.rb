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
			
			if(request.referer == "http://localhost:3000" + beer_club_path(@membership.beer_club))
				redirect_to beer_club_path(@membership.beer_club), notice: @membership.user.username + ", welcome to the club!"
			else
				redirect_to user_path(current_user)
			end
		else
			@beer_clubs = BeerClub.all
			render :join
		end
	end
end