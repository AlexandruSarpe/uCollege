require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#students' do
  let(:acting_student) {User.create(roles: %w(student))}
  subject(:student_ability) {Ability.new(acting_student)}

#   # Define your ability tests thus;
#   describe 'on Student' do
#     let(:student) { FactoryGirl.create(student) }
#
#     it { is_expected.to be_able_to(:index,   Student) }
#     it { is_expected.to be_able_to(:show,    student) }
#     it { is_expected.to be_able_to(:read,    student) }
#     it { is_expected.to be_able_to(:new,     student) }
#     it { is_expected.to be_able_to(:create,  student) }
#     it { is_expected.to be_able_to(:edit,    student) }
#     it { is_expected.to be_able_to(:update,  student) }
#     it { is_expected.to be_able_to(:destroy, student) }
#   end
#   # on Student
end
