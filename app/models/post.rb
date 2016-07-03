class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :school
  has_many :comments, dependent: :destroy
  has_many :flags, as: :flaggable
  validates :title, presence: true
  validates :body, presence: true
end
