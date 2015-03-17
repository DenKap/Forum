class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.integer :country
    	t.string :login
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :city
      t.timestamps null: false
    end
  end
end
