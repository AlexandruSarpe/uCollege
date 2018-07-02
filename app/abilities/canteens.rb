Canard::Abilities.for(:canteen) do
  # TODO: check these permissions when the corresponding model will be created
  can :manage, :Menu
  can :read, :Reservation
end
