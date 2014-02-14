require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi", id:2) ] )

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  
  it "if many are returned by the API, it is shown at the page" do
  	external_api
  	visit places_path
  	fill_in('city', :with => 'kumpula')
  	click_button "Search"
  	
  	places_in_array.each do |p|
  		expect(page).to have_content(p)
  	end
  end
  	
  it "if none are returned by the API, message is shown" do
	BeermappingApi.stub(:places_in).with("kumpula").and_return([ ])
  	visit places_path
  	fill_in('city', :with => 'kumpula')
  	click_button "Search"
  	
  	expect(page).to have_content("No locations in " + location_name)
  end
  
  def external_api
  	BeermappingApi.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi", id:1), Place.new(:name => "Teti", id:2), 
  	Place.new(:name => "Testi", id:3), Place.new(:name => "Baari", id:4)] )
  end
  
  def places_in_array
  	return ["Oljenkorsi", "Teti", "Testi", "Baari"]
  end
  
  def location_name
  	return "kumpula"
  end
end