# frozen_string_literal: true

# secretary user
class Secretary < User
  acts_as_user roles: :secretary
end
