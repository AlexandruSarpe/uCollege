# frozen_string_literal: true

Canard::Abilities.for(:secretary) do
  alias_action :create, :read, :update, :destroy, to: :crud
  can %i[crud view], :Course
  can :crud, :Student
  can :crud, :Canteen
  can :crud, :Secretary
  can %i[read update delete add], :Enrollment
  can :create, :Drive_auth
  can %i[create delete read], :Material
  can :crud, :Official_Event
  can %i[read delete], :Unofficial_Event
end
