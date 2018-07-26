# menu reservations
class Reservation < ApplicationRecord
  validates_presence_of :student
  validates_presence_of :menu

  belongs_to :student, dependent: :delete
  belongs_to :menu, dependent: :delete
end
