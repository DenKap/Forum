class Category < ActiveRecord::Base

	has_many :topics, dependent: :destroy

end
