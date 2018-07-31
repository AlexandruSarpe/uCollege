# frozen_string_literal: true
class MenusController < ApplicationController
  before_action :authenticate_user!
	skip_before_action :authenticate_user!, only: [:index]

  # Permette la visualizzazione di tutti i menu della settimana corrente
  def index
    authorize! :read, :Menu
  end

  # Permette la visualizzazione di tutti i menu
  def indexAll
    authorize! :read, :Menu
  end

  # Permette di vedere la pagine di creazione di un nuovo menu
  def new
    authorize! :create, :Menu
    @menu=Menu.create
  end

  # Permette di modifare un menu precedentemente scritto
  def edit
    authorize! :update, :Menu
    # Trova il menu da editare
    @menu = Menu.find(params[:id])
  end

  # Permette di mostrare le informazioni di un menu nello specifico
  def show
    authorize! :read, :Menu
    # Trova il menu da mostrare
    @menu = Menu.find(params[:id])
  end

  # Permette di creare nella maniera corretta un nuovo menu
  def create
    authorize! :create, :Menu
    # Ottiene i parametri del menu passati dalla pagina web
    data = params.require(:menu).permit(:date, :mealType, :firstCourse, :secondCourse, :sideDish, :notes, :canteen)
    # Controlla se la data inserita per il menu e' corretta
    # Controlla se e' stata selezionata la giusta voce per il tipo di pasto
    if(data[:date].to_date() < Date.today.at_beginning_of_week && date[:date].to_date() > Date.today.at_beginning_of_week &&
      (data[:mealType] == "lunch" || data[:mealType] == "dinner"))
      # Comunica un messaggio
      flash[:warning] = 'Incorrect selected date'
    else
      # Imposta l'utente che ha effettuato la richiesta
      # come utente proprietario del menu
      data[:canteen] = current_user
      # Controlla se un menu per questa data e questo pasto esistono già
      unless Menu.where('date=? and mealType=?', data[:date], data[:mealType]).empty?
        # Comunica un messaggio
        flash[:warning] = 'Already existing Menu'
        # Reindirizza l'utente
        redirect_to menus_path
        return
      end
      # Crea un istanza del nuovo menu
      @menu = Menu.new(data)
      # Salva il menu nel db
      res = @menu.save
      # Controlla se l'operazione e' andata a buon fine
      # e comunica un messaggio
      if res
        flash[:notice] = 'Menu created'
      else
        flash[:warning] = 'Cannot create menu'
      end
      # Reindirizza l'utente
      redirect_to new_menu_path
    end
  end

  # Permette di riflettere le modifiche apportate
  # ad un menu precedentemente creato sul db
  def update
    authorize! :update, :Menu
    # Ottiene i parametri del menu passati dalla pagina web
    data = params.require(:menu).permit(:date, :mealType, :firstCourse, :secondCourse, :sideDish, :notes, :canteen)
    # Controlla se la data inserita per il menu e' corretta
    # Controlla se e' stata selezionata la giusta voce per il tipo di pasto
    if(data[:date].to_date() < Date.today.at_beginning_of_week && date[:date].to_date() > Date.today.at_beginning_of_week &&
      (data[:mealType] == "lunch" || data[:mealType] == "dinner"))
      # Comunica un messaggio
      flash[:warning] = 'Incorrect selected date or meal'
    else
      # Trova il menu da modificare
      @menu = Menu.find(params[:id])
      # Aggiorna i dati del menu
      res = @menu.update(data)
      # Controlla se l'operazione e' andata a buon fine
      # e comunica un messaggio
      if res
        flash[:notice] = 'Menu updated'
      else
        flash[:warning] = 'Cannot update menu'
      end
      # Reindirizza l'utente
      redirect_to menus_path
    end
  end

  def destroy
    authorize! :destroy, :Menu
    # Trova il menu da eliminare
    @menu = Menu.find(params[:id])
    # Cencella il menu
    @menu.destroy
    # Comunica un messaggio
    flash[:notice] = 'Menu deleted'
    # Reindirizza l'utente
    redirect_to menus_path
  end
end
