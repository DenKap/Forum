class UserRole < ActiveRecord::Base

	validates :user_id, :role_id, presence: true
	validates :user_id, uniqueness: { scope: :role_id }

	belongs_to :user
	belongs_to :role

end
