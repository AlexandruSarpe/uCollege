# menu model
class Menu < ApplicationRecord
  validates_presence_of :date
  validates_presence_of :mealType
  
  belongs_to :writtenBy, class_name: 'Canteen'
  has_many :menuReservation, class_name: 'Reservation', foreign_key: 'add_index', dependent: :delete_all
end
