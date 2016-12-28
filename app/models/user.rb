class User < ActiveRecord::Base
  enum role: {user: 1, admin: 2, super_admin: 3}
	has_secure_password
  has_many :posts
end
