require 'spec_helper'

# Tehtava viisi
describe "Beer" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:style) { "IPA" }
	
	it "Creates beer in new beer page with valid name" do
		visit new_beer_path
		fill_in('beer[name]', with: 'Testi')
		
		click_button("Create Beer")
		expect(Beer.all.count).to be(1)
	end
	
	it "Gives error message if name is empty, doesn't save new beer and return to new beer page" do
		visit new_beer_path
		click_button("Create Beer")
		
		expect(page).to have_content "Name can't be blank"
		expect(Beer.all.count).to be(0)
	end
end