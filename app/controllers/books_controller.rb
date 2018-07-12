class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy , :borrow, :returnbook, :find]
  #befor_action authenticate_user!
  def index
    #@books = Book.all.order("created_at DESC")
    if params[:title]
      @books = Book.where('title LIKE ?', "#{params[:title]}").all.order("created_at DESC")
    else
      @books = Book.all.order("created_at DESC")
    end
  end

  def show

  end

  def new
    @book=Book.new
  end

  def create
    parametri = param
    parametri[:owner_id] = current_user.id
    parametri[:current_owner_id] = current_user.id
    @book=Book.new(parametri)

    if @book.save
      redirect_to books_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(param)
      redirect_to book_path(@book)
    else
      render 'edit'
    end

  end

  def borrow
    if @book.owner_id == @book.current_owner_id && @book.owner_id != current_user
      @book.update(:current_owner => current_user)
      flash[:notice] = "You borrow #{@book.title}."
      redirect_to books_path(@book)
    else
      flash[:notice] = "You can't borrow #{@book.title}."
    end
  end

  def returnbook
    if @book.current_owner_id == current_user.id && @book.owner_id != current_user.id
      @book.update(:current_owner_id => @book.owner_id)
      flash[:notice] = "You return #{@book.title}."
      redirect_to books_path(@book)
    else
      flash[:notice] = "You can't return #{@book.title}."
    end

  end


  def find
    redirect_to book_path(@book)
  end



  def destroy
    if current_user.id == @book.owner_id
      @book.destroy
      flash[:notice] = "#{@book.title} has been destroyed."
      redirect_to books_path
    else
      flash[:notice] = "You can't remove #{@book.title}."
    end
  end

  private

    def param

      params.require(:book).permit(:title, :description, :author ,:owner , :current_owner)

    end

    def find_book
      @book = Book.find(params[:id])
    end
end
