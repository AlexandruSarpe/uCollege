Canard::Abilities.for(:canteen) do
  alias_action :create, :read, :update, :destroy, to: :crud
  # TODO: check these permissions when the corresponding model will be created
  can :crud, :Menu
  can :read, :Reservation
end
