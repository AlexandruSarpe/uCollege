# frozen_string_literal: true

Canard::Abilities.for(:secretary) do
  alias_action :create, :read, :update, :destroy, to: :crud
  # TODO: check these permissions when the corresponding model will be created
  can :crud, :Event, official: true
  can :crud, :Course
  can :crud, :Student
  can :crud, :Canteen
  can :crud, :Secretary
end