class Gossip < ApplicationRecord
  belongs_to :user
  has_many :gossips_tags, dependent: :destroy
  has_many :tags, through: :gossips_tags
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, :content, presence: true
  validates :title, length: { minimum: 3 }
end
