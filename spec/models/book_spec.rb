# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'Create Book' do
    student = FactoryBot.create(:student)
    book = FactoryBot.build(:book)
    book.update(owner_id: student.id, current_owner_id: student.id)
    expect(book).to be_valid
  end

  it 'is not valid without a title' do
    student = FactoryBot.create(:student)
    book = FactoryBot.build(:book, title: nil)
    book.update(owner_id: student.id, current_owner_id: student.id)
    expect(book).to_not be_valid
  end

  it 'is not valid without a author' do
    student = FactoryBot.create(:student)
    book = FactoryBot.build(:book, author: nil)
    book.update(owner_id: student.id, current_owner_id: student.id)
    expect(book).to_not be_valid
  end

  it 'is not valid without description' do
    student = FactoryBot.create(:student)
    book = FactoryBot.build(:book, description: nil)
    book.update(owner_id: student.id, current_owner_id: student.id)
    expect(book).to_not be_valid
  end

  it 'is not valid without a owner_id' do
    student = FactoryBot.create(:student)
    book = FactoryBot.build(:book)
    book.update(current_owner_id: student.id)
    expect(book).to_not be_valid
  end

  it 'is not valid without a current_owner_id' do
    student = FactoryBot.create(:student)
    book = FactoryBot.build(:book)
    book.update(owner_id: student.id)
    expect(book).to_not be_valid
  end
end
