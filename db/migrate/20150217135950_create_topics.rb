class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
    	t.integer :topic_id
    	t.integer :user_id
    	t.string :title 
    	t.text :description
    	t.datetime :created_at
    	t.datetime :updated_at
      t.timestamps null: false
    end
  end
end
