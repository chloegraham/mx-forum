class User < ActiveRecord::Base
  enum role: ["user", "admin", "super_admin"]
  before_save { email.downcase! }
  #attr_accessor :email, :password_digest #:password, :password_confirmation
	has_secure_password
  has_many :posts, dependent: :destroy
  validates :first_name,  presence: true
  validates :password, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                   format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }

# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def feed
    Post.where("user_id = ?", id)
  end
  
end
  