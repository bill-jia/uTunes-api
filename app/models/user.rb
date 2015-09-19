class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :playlists, dependent: :destroy
  
  before_save -> do
    self.uid = SecureRandom.uuid
    # Skips email confirmation
    skip_confirmation!
  end  

  def admin?
  	return self.role == "admin"
  end

  def producer?
  	return self.role == "admin" || self.role == "producer"
  end
end
