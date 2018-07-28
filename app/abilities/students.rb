# frozen_string_literal: true

Canard::Abilities.for(:student) do
  alias_action :create, :read, :update, :destroy, to: :crud
  can :view, :Course
  can %i[read update delete], :Student
  can %i[create read], :Material
  can :add, :Enrollment
  can :crud, :Book
  # TODO: check these permissions when the corresponding model will be created
  can :crud, :Event, official: false
  can :crud, :Reservation
  can :read, :Menu
  can %i[view update], :Event, official: true
end
