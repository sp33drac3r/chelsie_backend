class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :school
  has_many :comments
  has_many :flags, as: :flaggable
end
