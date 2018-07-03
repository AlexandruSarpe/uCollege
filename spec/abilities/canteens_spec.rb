require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#canteens' do
  let(:acting_canteen) {User.create(roles: %w(canteen))}
  subject(:canteen_ability) {Ability.new(acting_canteen)}

#   # Define your ability tests thus;
#   describe 'on Canteen' do
#     let(:canteen) { FactoryGirl.create(canteen) }
#
#     it { is_expected.to be_able_to(:index,   Canteen) }
#     it { is_expected.to be_able_to(:show,    canteen) }
#     it { is_expected.to be_able_to(:read,    canteen) }
#     it { is_expected.to be_able_to(:new,     canteen) }
#     it { is_expected.to be_able_to(:create,  canteen) }
#     it { is_expected.to be_able_to(:edit,    canteen) }
#     it { is_expected.to be_able_to(:update,  canteen) }
#     it { is_expected.to be_able_to(:destroy, canteen) }
#   end
#   # on Canteen
end
