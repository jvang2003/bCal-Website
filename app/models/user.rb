class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :password_digest, :role, :email, :password, :password_confirmation

  validates :name, presence: true
  validates :email, presence: true
  validates :role, presence: true
  validates :password_digest, length: { minimum: 6 }
  before_save { self.email = email.downcase }
  before_create :create_remember_token


  def is_admin?
    return role > 0
  end

  def is_role? val
    return role == val
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
