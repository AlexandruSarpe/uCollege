# frozen_string_literal: true

Canard::Abilities.for(:guest) do
  can [:create], :Student
	can :read, :Menu
end
