class Topic < ActiveRecord::Base

	# validation

 	validates :title, :description, presence: true, length: { minimum: 2 }
 	validates :user_id, :category_id, presence: true

	# relations

	belongs_to :category
	belongs_to :user
  has_many :posts, dependent: :destroy

end
