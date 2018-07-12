# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without a type' do
    usr = FactoryBot.build(:user)
    expect(usr).not_to be_valid
  end

  it 'is a Secretary' do
    secretary = FactoryBot.create(:secretary)
    expect(User.where('email=?', secretary.email).first).to be_instance_of Secretary
  end

  it 'is a Canteen' do
    canteen = FactoryBot.create(:canteen)
    expect(User.where('email=?', canteen.email).first).to be_instance_of Canteen
  end

  it 'is a Student' do
    student = FactoryBot.create(:student)
    expect(User.where('email=?', student.email).first).to be_instance_of Student
  end

  it 'is invalid without a first name' do
    usr = FactoryBot.build(:student, first_name: nil)
    expect(usr).not_to be_valid
  end

  it 'is invalid without a last name' do
    usr = FactoryBot.build(:student, last_name: nil)
    expect(usr).not_to be_valid
  end

  it 'is invalid without a username' do
    usr = FactoryBot.build(:student, username: nil)
    expect(usr).not_to be_valid
  end

  it 'is invalid without a email' do
    usr = FactoryBot.build(:student, email: nil)
    expect(usr).not_to be_valid
  end
  it 'is invalid without a password' do
    usr = FactoryBot.build(:student, password: nil)
    expect(usr).not_to be_valid
  end
end
