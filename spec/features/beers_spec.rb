require 'spec_helper'

# Tehtava viisi
describe "Beer" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:style) { FactoryGirl.create :style }
	
	it "Creates beer in new beer page with valid name" do
		sign_in_user
		visit new_beer_path
		fill_in('beer[name]', with: 'Testi')
		
		click_button("Create Beer")
		expect(Beer.all.count).to eq(1)
	end
	
	it "Gives error message if name is empty, doesn't save new beer and return to new beer page" do
		sign_in_user
		visit new_beer_path
		click_button("Create Beer")
		
		expect(page).to have_content "Name can't be blank"
		expect(Beer.all.count).to be(0)
	end
	
	def sign_in_user
		FactoryGirl.create(:user)
		sign_in(username: "Pekka", password: "Foobar1")
	end
end