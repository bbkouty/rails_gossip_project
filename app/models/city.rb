class City < ApplicationRecord
    has_many :users, dependent: :destroy
    
    validates :name, :zip_code, presence: true    
end
