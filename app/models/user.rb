class User < ActiveRecord::Base

  attr_accessor :new_password

	before_save :encrypt_password
  after_create :set_registered_role

  validates_presence_of :login, :email, :password
  validates_length_of :login, :within => 2..30
  validates_length_of :password, :within => 8..40
  validates_uniqueness_of :login, :email, case_sensitive: false
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/i }
  
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  belongs_to :country

  def has_role?(role)
    return false if role.blank?
    self.roles.include?(role)
  end

  def can_edit_topic?(topic)
    self.has_role?(Role.admin) || self == topic.user
  end

  def can_edit_post?(post)
    self.has_role?(Role.admin) || self == post.user
  end

	private

  def encrypt_password
    self.password = self.new_password if self.new_password.present?
    return if (password.blank? || !password_changed?)
    self.password = Digest::SHA1.hexdigest(self.password)
  end

  def set_registered_role
    UserRole.create(user_id: self.id, role_id: Role.registered.id)
  end

 	def self.authenticate(login, password)
    User.find_by(login: login, password: Digest::SHA1.hexdigest(password)) rescue nil
  end


end
