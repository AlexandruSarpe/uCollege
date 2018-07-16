# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_book, only: %i[show edit update destroy borrow returnbook find]
  before_action :authenticate_user!
  def index
    authorize! :read, :Book
    # @books = Book.all.order("created_at DESC")
    if params[:title]
      @books = Book.where('title LIKE ?', params[:title].to_s).all.order('created_at DESC')
    else
      @books = Book.all.order('created_at DESC')
    end
  end

  def show
    authorize! :read, :Book
  end

  def new
    authorize! :create, :Book
    @book = Book.new
  end

  def create
    authorize! :create, :Book
    parametri = param
    parametri[:owner_id] = current_user.id
    parametri[:current_owner_id] = current_user.id
    @book = Book.new(parametri)

    if @book.save
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
    authorize! :update, :Book

    if @book.owner != current_user
      flash[:warning] = 'You cannot edit a book that is not yours'
      redirect_to book_path(@book)
    end
  end

  def update
    authorize! :update, :Book
    if @book.owner != current_user
      flash[:warning] = 'You cannot update a book that is not yours'
      redirect_to(book_path(@book)) && return
    end
    if @book.update(param)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def borrow
    authorize! :update, :Book
    if @book.owner_id == @book.current_owner_id && @book.owner_id != current_user
      @book.update(current_owner: current_user)
      flash[:notice] = "You borrow #{@book.title}."
      redirect_to books_path(@book)
    else
      flash[:notice] = "You can't borrow #{@book.title}."
    end
  end

  def returnbook
    authorize! :update, :Book
    if @book.current_owner_id == current_user.id && @book.owner_id != current_user.id
      @book.update(current_owner_id: @book.owner_id)
      flash[:notice] = "You return #{@book.title}."
      redirect_to books_path(@book)
    else
      flash[:notice] = "You can't return #{@book.title}."
    end
  end

  def find
    authorize! :read, :Book
    redirect_to book_path(@book)
  end

  def destroy
    authorize! :destroy, :Book
    if @book.owner != current_user
      flash[:warning] = 'You cannot delete a book that is not yours'
      redirect_to(book_path(@book)) && return
    end
    if @book.current_owner == @book.owner
      @book.destroy
      flash[:notice] = "#{@book.title} has been destroyed."
      redirect_to books_path
    else
      flash[:notice] = "You can't remove #{@book.title}, it's borrowed!"
    end
  end

  private

  def param
    params.require(:book).permit(:title, :description, :author, :owner, :current_owner)
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
