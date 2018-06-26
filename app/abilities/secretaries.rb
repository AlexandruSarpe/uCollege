# frozen_string_literal: true

Canard::Abilities.for(:secretary) do
  # TODO: check these permissions when the corresponding model will be created
  can :manage, :Event, official: true
  can :manage, :Course
end
