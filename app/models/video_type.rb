class VideoType < ApplicationRecord
  has_many :videos, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

end
