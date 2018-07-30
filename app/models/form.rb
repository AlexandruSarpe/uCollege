class Form < ApplicationRecord
  validates_presence_of :dateStart
  validates_presence_of :dateEnd

  belongs_to :canteen
end
