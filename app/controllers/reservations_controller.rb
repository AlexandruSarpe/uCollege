# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :authenticate_user!

  # Permette la possibilità di visualizzare il menu odierno e prenotarsi
  def index
    authorize! :read, :Reservation
  end

  # Permette di vedere la pagine di creazione
  # di una nuova prenotazione per uno studente
  def new
    authorize! :create, :Reservation
    # Controllo se non è scaduto il tempo per la prenotazione
    if Time.now.strftime("%d/%m/%Y %H:%M") < Time.now.strftime("%d/%m/%Y")+" 11:00"
      @menu = Menu.find(params[:menu_id])
      @reservation = Reservation.create
    else
      # Se sono l'utente mensa posso effettuare
      # prenotazioni anche dopo il termine del tempo
      if current_user.instance_of? Canteen
        @menu = Menu.find(params[:menu_id])
        @reservation = Reservation.create
      else
        flash[:notice] = 'Time for reservations terminated'
        redirect_to reservations_path
      end
    end
  end

    # Permette di vedere la pagine di creazione 
    # di una nuova prenotazione per un ospite
  def newGuest
    authorize! :create, :Reservation
    # Controllo se non è scaduto il tempo per la prenotazione
    if Time.now.strftime("%d/%m/%Y %H:%M") < Time.now.strftime("%d/%m/%Y")+" 18:00"
      @menu = Menu.find(params[:menu_id])
      @reservation = Reservation.create
    else
      flash[:notice] = 'Time for reservations terminated'
      redirect_to reservations_path
    end
  end

  # Permette di vedere la pagina per editare una prenotazione
  def edit
    authorize! :update, :Reservation
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.find(params[:id])
  end

  # Permette di visualizzare le informazioni
  # relative ad una prenotazione
  def show
    authorize! :read, :Reservation
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.find(params[:id])
  end

  # Permette di creare nella maniera corretta una nuova prenotazione
  def create
    authorize! :create, :Reservation
    # Trova il menu per cui l'utente si sta prenotando
    @menu = Menu.find(params[:menu_id])
    # Ottiene i parametri del menu passati dalla pagina web
    data = params.require(:reservation).permit(:typeReservation, :firstCourseAlternatives, :secondCourseAlternatives, :sideDishAlternatives, :sideDish, :notes, :student, :menu)
    # La seguenza di if sottostanti permette all'utente mensa 
    # di effettuare una prenotazione per un utente
    # Controlla se l'elemento dal nome email e' definito
    # tra i paramentri acquisiti dalla pagina web
    if params[:email].present?
      # Ottengo l'identificativo dell'utente dal suo indirizzo email (chiave)
      data[:student] = Student.all.where(email: params[:email]).take
    else
      # Altrimenti imposto l'attuale utente come proprietario della prenotazione
      data[:student] = current_user
    end
    # Controlla se la prenotazione e' per un ospite
    if data[:typeReservation].include? "guest" 
      # Controlla se il numero per l'ospite e' presente
      if params[:number].present?
        # Combina la stringa "guest" con il numero passato
        data[:typeReservation] = data[:typeReservation] + params[:number]
      end
    end
    # Controlla se sia stato effettivamente selezionato
    # il tipo di prenotazione (forse meglio un or con !=)
    if data[:typeReservation].include? "none"
      # Comunica un messaggio
      flash[:notice] = 'You have chosen not to make a reservation'
    else
      # Controlla se e' presente il campo "delete" tra i parametri passato
      # se presente indica che la prenotazione per un determinato utente
      # deve essere cancellata
      if params[:delete].present?
        # Trova la prenotazione e la elimina
        myDestroy(Reservation.all.where(student: data[:student], menu: @menu, typeReservation: data[:typeReservation]).take.id)
      else
        # Imposta il menu corrente come munu di selezione
        data[:menu] = @menu
        # Controlla se esiste gia' una prenotazione si fatta
        unless Reservation.where('typeReservation=? and student_id=? and menu_id=?', data[:typeReservation], data[:student], data[:menu]).empty?
          flash[:warning] = 'Already existing Reservation'
          # Reindirizza l'utente secondo la sua tipologia
          if current_user.instance_of? Student
            redirect_to reservations_path
          end
          if current_user.instance_of? Canteen
            redirect_to new_menu_reservation_path(@menu.id)
          end
          return
        end
        # Crea un istanza della nuova prenotazione
        @reservation = Reservation.new(data)
        # Salva la prenotazione nel db
        res = @reservation.save
        # Controlla se l'operazione e' andata a buon fine
        if res
          # Comunica un messaggio
          flash[:notice] = 'Reservation created'
        else
          # Comunica un messaggio
          flash[:warning] = 'Cannot create reservation'
        end
      end
    end
    # Reindirizza l'utente secondo la sua tipologia
    if current_user.instance_of? Student
      redirect_to reservations_path
    end
    if current_user.instance_of? Canteen
      redirect_to new_menu_reservation_path(@menu.id)
    end
  end

  # Permette di riflettere le modifiche apportate
  # ad una prenotazione precedentemente creata sul db
  def update
    authorize! :update, :Reservation
    # Ottiene i parametri del menu passati dalla pagina web
    data = params.require(:reservation).permit(:typeReservation, :firstCourseAlternatives, :secondCourseAlternatives, :sideDishAlternatives, :sideDish, :notes, :student, :menu)
    # Controlla se sia stato effettivamente selezionato
    # il tipo di prenotazione (forse meglio un or con !=)
    if data[:typeReservation] == "none"
      flash[:notice] = 'To cancel the reservation click on the delete link'
    else
      # Trova la prenotazione da modificare
      @reservation = Reservation.find(params[:id])
      # Aggiorna i dati del menu
      res = @reservation.update(data)
      # Controlla se l'operazione e' andata a buon fine
      # e comunica un messaggio
      if res
        flash[:notice] = 'Reservation updated'
      else
        flash[:warning] = 'Cannot update reservation'
      end
    end
    # Reindirizza l'utente
    redirect_to menu_reservation_path
  end

  def destroy
    authorize! :destroy, :Reservation
    # Trova la prenotazione da eliminare
    @reservation = Reservation.find(params[:id])
    # Elimina la prenotazione
    @reservation.destroy
    # Comunica un messaggio
    flash[:notice] = 'Reserve deleted'
    # Reindirizza l'utente
    redirect_to reservations_path
  end

  protected
  
  def myDestroy(reservation_id)
    # Trova la prenotazione da eliminare
    @reservation = Reservation.find(reservation_id)
    # Elimina la prenotazione
    @reservation.destroy
    # Comunica un messaggio
    flash[:notice] = 'Reserve deleted'
  end
end