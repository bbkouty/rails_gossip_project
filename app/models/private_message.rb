class PrivateMessage < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :recipients, dependent: :destroy
  has_many :users, through: :recipients
end
