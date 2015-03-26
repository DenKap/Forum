class Post < ActiveRecord::Base

	# validations

	validates :description, presence: true, length: { minimum: 2 }
	validates :user_id, :topic_id, presence: true

	# relations
	
	belongs_to :topic
	belongs_to :user
	
end
