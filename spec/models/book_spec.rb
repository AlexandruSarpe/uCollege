require 'rails_helper'

RSpec.describe Book, type: :model do
  it  "Create Book" do
      Student.new(:email => "prova1@email.com", :password => "prova1", :password_confirmation => "prova1").save!
      @student=Student.where(["email = ?", "prova1@email.com"]).first
      @book=Book.new(:title => "Book1", :author => "Moravia", :description => "Poetry")
      @book.update(:owner_id => @student.id, :current_owner_id => @student.id)
      expect(@book).to be_valid
    end

    it "is not valid without a title" do
      Student.new(:email => "prova1@email.com", :password => "prova1", :password_confirmation => "prova1").save!
      @student=Student.where(["email = ?", "prova1@email.com"]).first
      @book=Book.new(:title => nil)
      @book.update(:owner_id => @student.id, :current_owner_id => @student.id)
      expect(@book).to_not be_valid
    end

    it "is not valid without a author" do
      Student.new(:email => "prova1@email.com", :password => "prova1", :password_confirmation => "prova1").save!
      @student=Student.where(["email = ?", "prova1@email.com"]).first
      @book=Book.new(:title => "Book1", :author => nil)
      @book.update(:owner_id => @student.id, :current_owner_id => @student.id)
      expect(@book).to_not be_valid
    end

    it "is not valid without description" do
      Student.new(:email => "prova1@email.com", :password => "prova1", :password_confirmation => "prova1").save!
      @student=Student.where(["email = ?", "prova1@email.com"]).first
      @book=Book.new(:title => "Book1", :author => "Moravia", :description => nil)
      @book.update(:owner_id => @student.id, :current_owner_id => @student.id)
      expect(@book).to_not be_valid
    end

    it "is not valid without a owner_id" do
      Student.new(:email => "prova1@email.com", :password => "prova1", :password_confirmation => "prova1").save!
      @student=Student.where(["email = ?", "prova1@email.com"]).first
      @book=Book.new(:title => "Book1", :author => "Moravia", :description => "Poetry")
      @book.update(:current_owner_id => @student.id)
      expect(@book).to_not be_valid
    end

    it "is not valid without a current_owner_id" do
      Student.new(:email => "prova1@email.com", :password => "prova1", :password_confirmation => "prova1").save!
      @student=Student.where(["email = ?", "prova1@email.com"]).first
      @book=Book.new(:title => "Book1", :author => "Moravia")
      @book.update(:owner_id => @student.id)
      expect(@book).to_not be_valid
    end

end
