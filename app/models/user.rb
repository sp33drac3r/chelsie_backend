class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :flags
  has_secure_password
end
