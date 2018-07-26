# menu model
class Menu < ApplicationRecord
  validates_presence_of :date
  validates_presence_of :mealType
  
  belongs_to :canteen, dependent: :delete
  has_many :reservations, dependent: :delete_all
end
