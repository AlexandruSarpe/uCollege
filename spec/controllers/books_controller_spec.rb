require 'rails_helper'
require 'spec_helper'
require 'rspec/rails'
require 'devise'

RSpec.describe BooksController, type: :controller do
	before :each do
		@student1 = FactoryBot.create(:student1)
		@student2 = FactoryBot.create(:student2)
	end
    describe "Create book" do

      it "views the creation page" do
				sign_in @student1
        get :new
        expect(response).to render_template(:new)
      end
      it "creates the book" do
				sign_in @student1
            post :create, params: {book: {title: "Book1", author: "Ignoto", description: "Fantasy",
                 owner_id: @student1.id , current_owner_id: @student1.id}}
            books = Book.where(["title = ?", "Book1"]).first
            expect(books).not_to eq(nil)
      end
    end
    describe "Borrow book" do
      it "Borrows the book" do
				@book = FactoryBot.create(:book1)
				sign_in @student1
        post :borrow, params: {id: @book.id}
				@book.reload
        expect(@book.current_owner_id).to eq(@student1.id)
      end
    end
		describe "Return book" do
      it "Returns the book" do
				@book = FactoryBot.create(:book1)
				sign_in @student1
        post :borrow, params: {id: @book.id}
				@book.reload
				post :returnbook, params: {id: @book.id}
				@book.reload
        expect(@book.current_owner_id).to eq(@book.owner_id)
      end
    end

end
