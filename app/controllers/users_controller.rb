class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @ratings = @user.ratings
    @beer_clubs = @user.beer_clubs
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if(!currently_signed_in?(@user))
    	redirect_to signin_path
    end
  end

  # POST /users
  # POST /users.json
  def create
     @user = User.new username: params[:user][:username], password: params[:user][:password]
     if(@user.save)
     	redirect_to users_path
     else
     	render :new
     end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    
    if(!currently_signed_in?(@user))
    	redirect_to signin_path
    	return
    end
    
	if(@user.update_attributes(password: params[:user][:password]))
		redirect_to user_path(@user)
	else
		render :edit
	end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
