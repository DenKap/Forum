class Category < ActiveRecord::Base

	# validations

	validates :name, :description, presence: true, length: { minimum: 2 }

	# relations

	has_many :topics, dependent: :destroy

end
