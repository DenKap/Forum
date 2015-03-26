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
      t.string :reset_password_token
      t.timestamp :reset_password_requested_at
      t.timestamps null: false
    end
  end
end
