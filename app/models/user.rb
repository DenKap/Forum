class User < ActiveRecord::Base

  attr_accessor :new_password

	before_save :encrypt_password
  after_create :set_registered_role

  validates :login, :email, :password, presence: true
  validates :login, length: { within: 2..30 }
  validates :password, length: { within: 8..40 }
  validates_uniqueness_of :login, :email, case_sensitive: false
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/i }
  validates :new_password, length: { in: 8..40 }, allow_blank: true

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

  def reset_password!
    self.update({reset_password_token: Digest::SHA1.hexdigest("#{self.id}-#{self.email}-#{Time.now}"), reset_password_requested_at: Time.now })    
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
    User.where("(login = :login OR email = :login) AND password=:password", login: login, password: Digest::SHA1.hexdigest(password)).first rescue nil
  end

end
