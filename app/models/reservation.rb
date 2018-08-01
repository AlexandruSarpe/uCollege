# menu reservations
class Reservation < ApplicationRecord
  validates_presence_of :student
  validates_presence_of :menu

  belongs_to :student
  belongs_to :menu
end
