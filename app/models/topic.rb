class Topic < ActiveRecord::Base

	# validation

 	validates :title, :description, presence: true, length: { minimum: 2 }
 	validates :user_id, :category_id, presence: true

	# relations

	belongs_to :category
	belongs_to :user
  has_many :posts, dependent: :destroy

	def self.get_last_updated_topics(count = 5)
	  topics = []
	  Post.all.order("created_at DESC").each do |post|
	    topics << post.topic unless topics.include?(post.topic)
	    break if topics.count == count
	  end
	  return topics
	end

end
