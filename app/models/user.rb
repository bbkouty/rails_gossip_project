class User < ApplicationRecord
  belongs_to :city
  has_many :gossips, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :sent_messages, class_name: "PrivateMessage", foreign_key: "user_id", dependent: :destroy
  has_many :recipients,dependent: :destroy
  has_many :received_messages, through: :recipients, source: :private_message

  validates :first_name, :last_name, :email, presence: true
end
