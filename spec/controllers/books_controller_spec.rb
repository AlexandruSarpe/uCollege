# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before :each do
    @student = FactoryBot.create(:student)
    @student2 = FactoryBot.create(:student2)
  end
  describe 'Create book' do
    it 'views the creation page' do
      sign_in @student
      get :new
      expect(response).to render_template(:new)
    end
    it 'creates the book' do
      sign_in @student
      book = FactoryBot.build(:book)
      post :create, params: {book: {title: book.title, author: book.author, description: book.description,
                                    owner_id: @student.id, current_owner_id: @student.id}}
      books = Book.where(['title = ?', book.title]).first
      expect(books).not_to eq(nil)
    end
  end
  describe 'Borrow book' do
    it 'Borrows the book' do
      book = FactoryBot.build(:book)
      book.owner = @student2
      book.current_owner = @student2
      book.save
      sign_in @student
      post :borrow, params: {id: book.id}
      book.reload
      expect(book.current_owner_id).to eq(@student.id)
    end
  end
  describe 'Return book' do
    it 'Returns the book' do
      book = FactoryBot.build(:book)
      book.owner = @student2
      book.current_owner = @student2
      book.save
      sign_in @student
      book.update(current_owner_id: @student.id)
      book.reload
      post :returnbook, params: {id: book.id}
      book.reload
      expect(book.current_owner_id).to eq(book.owner_id)
    end
  end
end
