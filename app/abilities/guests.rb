# frozen_string_literal: true

Canard::Abilities.for(:guest) do
  can [:create], :Student
  can [:read], :Unofficial_Event
  can [:read], :Official_Event
end
