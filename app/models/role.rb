class Role < ActiveRecord::Base

	ADMIN = "admin"
	REGISTERED = "registered"

	validates_presence_of :name

	has_many :user_roles, dependent: :destroy
	has_many :users, through: :user_roles

	scope :admin, -> { find_by(name: ADMIN) }
	scope :registered, -> { find_by(name: REGISTERED) }

end
