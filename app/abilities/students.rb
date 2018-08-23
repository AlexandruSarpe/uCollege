# frozen_string_literal: true

Canard::Abilities.for(:student) do
  alias_action :create, :read, :update, :destroy, to: :crud
  can :view, :Course
  can %i[read update delete], :Student
  can %i[create read], :Material
  can :add, :Enrollment
  can :crud, :Book
  can :crud, :Notification
  can :crud, :Unofficial_Event
  can :crud, :Reservation
  can :view, :Menu
  can %i[view], :Official_Event
end