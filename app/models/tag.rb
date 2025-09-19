class Tag < ApplicationRecord
    has_many :gossips_tags, dependent: :destroy
    has_many :gossips, through: :gossips_tags, dependent: :destroy
end
