class User < ActiveRecord::Base

	# Attributes
  #----------------------------------------
  #

  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  # Validations
  #----------------------------------------
  #

  # name
  validates :name, presence: true, length: { maximum: 50 }
  
  # email
  before_save { email.downcase! }
  before_save :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # password
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # Associations
  #----------------------------------------
  #

  has_many :microposts

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
