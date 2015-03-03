class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
    	t.integer :user_id
      t.integer :category_id
    	t.string :title 
    	t.text :description
    end
  end
end
