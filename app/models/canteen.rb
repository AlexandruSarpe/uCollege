# frozen_string_literal: true

class Canteen < User
  acts_as_user roles: :canteen
end
