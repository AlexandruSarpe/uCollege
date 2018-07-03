# frozen_string_literal: true

Canard::Abilities.for(:student) do
  # TODO: check these permissions when the corresponding model will be created
  can %i[view update], :Course
  can :manage, :Event, official: false
  can :manage, :Reservation
  can :view, :Menu
  can %i[view update], :Event, official: true
  can :manage, :Book
end
