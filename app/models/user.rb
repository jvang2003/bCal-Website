class User < ActiveRecord::Base
  attr_accessible :name, :calnet_id, :role, :email

  validates :name, presence: true
  # validates :calnet_id, presence: true
  validates :email, presence: true
  def User.VALID_ROLES
    {
      "Guest" => 0,
      "Admin" => 1,
      "Dept Admin" => 2,
      "App Admin" => 3,
    }
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
