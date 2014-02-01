class RatingsController < ApplicationController

  def index
  	@ratings = Rating.all
  end
  
  def new
  	@rating = Rating.new
  	@beers = Beer.all
  end
  
  def create
  	if(current_user == nil)
  		redirect_to users_path
  		return
  	end
  	@rating = Rating.new beer_id: params[:rating][:beer_id], score: params[:rating][:score], user_id: current_user.id
  	if @rating.save
      redirect_to user_path current_user
    else
      @rating=Rating.new
      @beers = Beer.all
      render :new
    end
  end
  
  def destroy
  	rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end