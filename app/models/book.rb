# frozen_string_literal: true

class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :description
  belongs_to :owner, class_name: 'Student'
  belongs_to :current_owner, class_name: 'Student'
end
