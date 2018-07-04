# frozen_string_literal: true

Canard::Abilities.for(:student) do
  alias_action :create, :read, :update, :destroy, to: :crud
  # TODO: check these permissions when the corresponding model will be created
  can %i[view update], :Course
  can :crud, :Student
  can :crud, :Event, official: false
  can :crud, :Reservation
  can :view, :Menu
  can %i[view update], :Event, official: true
  can :crud, :Book
end
