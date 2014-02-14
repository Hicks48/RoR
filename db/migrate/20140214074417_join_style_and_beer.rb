class JoinStyleAndBeer < ActiveRecord::Migration
  def change
  	add_column :beers, :style_id, :integer
  	add_column :styles, :beer_id, :integer
  end
end
