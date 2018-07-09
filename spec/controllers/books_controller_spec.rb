require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before :each do
        @student1 = FactoryBot.create(:student1)
        sign_in @student1
    end
    describe "Create book" do
      it "view the creation page" do
        get :new
        expect(response).to render_template(:new)
      end
      it "creates the book" do
            post :create, params: {book: {title: "Book1", author: "Ignoto", description: "Fantasy",
                 owner_id: @student1.id , current_owner_id: @student1.id}}
            books = Book.where(["title = ?", "Book1"]).first
            expect(books).not_to eq(nil)
      end
    end
    describe "Borrow book" do
      it "Borrow the book" do
        @student2 = FactoryBot.create(:student2)
        @book = FactoryBot.create(:book1)
        post :borrow, params: {id: @book.id}
        expect(@book.current_owner_id).to eq(@student1.id)
      end
    end
end
