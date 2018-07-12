# frozen_string_literal: true

# canteen user
class Canteen < User
  acts_as_user roles: :canteen
end
