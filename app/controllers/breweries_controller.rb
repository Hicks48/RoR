class BreweriesController < ApplicationController
	#before_filter :authenticate, only: [:destroy]
	before_filter :ensure_that_signed_in, except: [:index, :show, :list]
	before_filter :ensure_that_is_admin, only: [:destroy]
  # GET /breweries
  # GET /breweries.json
  def index
    @breweries = Brewery.all
	@active_breweries = Brewery.active
    @retired_breweries = Brewery.retired
	
	order = params[:order]
	
	case order
		when 'name' then @breweries.sort_by!{|brew| brew.name}
		when 'year' then @breweries.sort_by!{|brew| brew.year}
	end
	
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @breweries , methods: [:beers]}
    end
  end
  
  def list
  end
    
  # GET /breweries/1
  # GET /breweries/1.json
  def show
    @brewery = Brewery.find(params[:id])
	@ratings = @brewery.ratings
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/new
  # GET /breweries/new.json
  def new
    @brewery = Brewery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/1/edit
  def edit
    @brewery = Brewery.find(params[:id])
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(params[:brewery])
    
    if(@brewery.nil?)
    	if(@brewery.year > Date.today.year)
    		@brewery.errors[:base] = "Year can't be in the future!"
    	end
    end
    if(@brewery.errors.any?)
    	render :new
    	return
    end
    
    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render json: @brewery, status: :created, location: @brewery }
      else
        format.html { render action: "new" }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /breweries/1
  # PUT /breweries/1.json
  def update
    @brewery = Brewery.find(params[:id])

    respond_to do |format|
      if @brewery.update_attributes(params[:brewery])
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery = Brewery.find(params[:id])
    @brewery.destroy

    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end
  
  #def authenticate
  #	admin_accounts = {"admin" => "secret", "pekka" => "beer", "arto" => "foobar", "matti" => "ittam"}
  #	authenticate_or_request_with_http_basic do |username, password|
  #		admin_accounts[username] != nil && admin_accounts[username] == password	
  #	end
  #end
end
