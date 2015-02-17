class User < ActiveRecord::Base

	before_save :encrypt_password

  validates_presence_of :login, :email, :password
  validates_length_of :login, :within => 2..30
  validates_length_of :password, :within => 8..30
  validates_uniqueness_of :login, :email
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/i }
  
  has_many :topics
  has_many :posts

	private

  def encrypt_password
   	self.password = Digest::MD5.hexdigest(password) if password.present?
 	end

 	def self.authenticate(email, password)
    User.find_by(email: email, password: Digest::MD5.hexdigest(password)) rescue nil
  end

end
