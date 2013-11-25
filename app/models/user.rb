class User < ActiveRecord::Base
  attr_accessible :name, :calnet_id, :role

  validates :name, presence: true
  validates :calnet_id, presence: true

  def is_admin?
    return role > 0
  end

  def is_role? val
    return role == val
  end

  def User.valid_roles
    {
      "Guest" => 0,
      "Admin" => 1,
      "App Admin" => 2,
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
