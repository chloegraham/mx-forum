class User < ActiveRecord::Base
  enum role: [:user, :admin, :super_admin]
  before_save { email.downcase! }
  #attr_accessor :email, :password_digest #:password, :password_confirmation
	has_secure_password
  has_many :posts
  validates :first_name,  presence: true
  validates :password, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                   format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }

    #              lass AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  #def change
   # add_index :users, :email, unique: true
  #end
end
  