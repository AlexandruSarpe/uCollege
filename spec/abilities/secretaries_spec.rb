require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#secretaries' do
  let(:acting_secretary) {User.create(roles: %w(secretary))}
  subject(:secretary_ability) {Ability.new(acting_secretary)}

#   # Define your ability tests thus;
#   describe 'on Secretary' do
#     let(:secretary) { FactoryGirl.create(secretary) }
#
#     it { is_expected.to be_able_to(:index,   Secretary) }
#     it { is_expected.to be_able_to(:show,    secretary) }
#     it { is_expected.to be_able_to(:read,    secretary) }
#     it { is_expected.to be_able_to(:new,     secretary) }
#     it { is_expected.to be_able_to(:create,  secretary) }
#     it { is_expected.to be_able_to(:edit,    secretary) }
#     it { is_expected.to be_able_to(:update,  secretary) }
#     it { is_expected.to be_able_to(:destroy, secretary) }
#   end
#   # on Secretary
end
