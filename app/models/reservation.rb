# menu reservations
class Reservation < ApplicationRecord
  validates_presence_of :reservationStudent
  validates_presence_of :reservationMenu

  belongs_to :reservationStudent, class_name: 'Student'
  has_many :reservationMenu, class_name: 'Menu', foreign_key: 'add_index', dependent: :delete_all
end
