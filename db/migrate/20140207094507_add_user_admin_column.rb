class AddUserAdminColumn < ActiveRecord::Migration
  def change
  	add_column :users, :admin, :boolean
  end
  #def up
  	#add_column :user, :admin, :boolean
  #end

  #def down
  #end
end
