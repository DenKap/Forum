class User < ActiveRecord::Base

	before_save :encrypt_password
  after_create :set_registered_role

  validates_presence_of :login, :email, :password
  validates_length_of :login, :within => 2..30
  validates_length_of :password, :within => 8..30
  validates_uniqueness_of :login, :email, case_sensitive: false
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/i }
  
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  def has_role?(role)
    return false if role.blank?
    self.roles.include?(role)
  end

	private

  def encrypt_password
   	self.password = Digest::MD5.hexdigest(password) if password.present?
 	end

  def set_registered_role
    UserRole.create(user_id: self.id, role_id: Role.registered.id)
  end

 	def self.authenticate(login, password)
    User.find_by(login: login, password: Digest::MD5.hexdigest(password)) rescue nil
  end

end
