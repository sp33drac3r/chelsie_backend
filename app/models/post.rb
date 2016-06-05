class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :school
  has_many :comments
  has_many :flags, as: :flaggable
end
