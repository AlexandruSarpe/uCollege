# frozen_string_literal: true

Canard::Abilities.for(:secretary) do
  alias_action :create, :read, :update, :destroy, to: :crud
  can %i[crud view], :Course
  can :crud, :Student
  can :crud, :Canteen
  can :crud, :Form
  can :crud, :Secretary
  can %i[read update delete add], :Enrollment
  can :create, :Drive_auth
  can %i[create delete read], :Material
  # TODO: check these permissions when the corresponding model will be created
  can :crud, :Event, official: true
end
