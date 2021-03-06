require 'spec_helper'

describe Beer do
  #Toinen tehtava
  it "Beer with name and style is saved" do
  	sty = Style.create name:"Testi_Style"
  	beer = Beer.create name:"Testi Olut", style: sty
  	
  	expect(beer).to be_valid
  	expect(Beer.count).to eq(1)
  end
  
  #Toinen tehtava
  it "Beer with no name is not saved" do
  	st = Style.create name:"IPA"
  	beer_1 = Beer.create style: st
  	beer_2 = Beer.create name:"", style: st
  	
  	expect(beer_1).not_to be_valid
  	expect(beer_2).not_to be_valid
  	expect(Beer.count).to eq(0)
  end
  
  #Toinen tehtava
  it "Beer with no style is not saved" do
  	beer_1 = Beer.create name:"Testi Olut 1"
  	beer_2 = Beer.create name:"Testi Olut 2", style: nil
  	
  	expect(beer_1).not_to be_valid
  	expect(beer_2).not_to be_valid
  	expect(Beer.count).to eq(0)
  end
end
