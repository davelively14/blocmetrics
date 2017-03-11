class RegisteredApplication < ActiveRecord::Base
  belongs_to :user

  validates :name, length: {minimum: 3, maximum: 30}, presence: true, uniqueness: true
  validates :url, length: {minimum: 3}, presence: true
  validates :user_id, presence: true
end
