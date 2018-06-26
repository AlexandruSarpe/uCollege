class Guest < User
  acts_as_user roles :guest
end
