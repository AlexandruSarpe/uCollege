class Student < User
  acts_as_user roles: :student
end
