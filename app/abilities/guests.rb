# frozen_string_literal: true

Canard::Abilities.for(:guest) do
  # TODO: check these permissions when the corresponding model will be created
  can :read, %i[Calendar Menu]
end
