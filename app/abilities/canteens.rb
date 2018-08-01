# frozen_string_literal: true

Canard::Abilities.for(:canteen) do
  alias_action :create, :read, :update, :destroy, to: :crud
  # TODO: check these permissions when the corresponding model will be created
  can :crud, :Menu
  can :read, :Canteen
  can :update, :Canteen
  can :crud, :Form
  can :read, :Reservation
  can :create, :Reservation
end
