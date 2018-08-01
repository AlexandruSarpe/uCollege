class FormsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :crud, :Form
  end

  def new
    authorize! :create, :Form
    @form=Form.create
  end

  def edit
    authorize! :update, :Form
    @form = Form.find(params[:id])
  end

  # Permette di mostrare le informazioni di un form nello specifico
  def show
    authorize! :read, :Form
    # Trova il menu da mostrare
    @form = Form.find(params[:id])
  end

  # Permette di mostrare le informazioni sui risultati di un form nello specifico
  def showResult
    authorize! :crud, :Form
    # Trova il menu da mostrare
    @form = Form.find(params[:form_id])
  end

  # Permette di creare nella maniera corretta un nuovo questionario
  def create
    authorize! :create, :Form
    # Ottiene i parametri del questionario passati dalla pagina web
    data = params.require(:form).permit(:dateStart, :dateEnd, :linkToForm, :linkToResult, :canteen)
    # Controlla se la data inserita per il form e' corretta
    if(data[:dateStart].to_date() >= Date.today || data[:dateEnd].to_date() > Date.today)
      # Controlla se i link verso le risorse esterne sono stati inseriti
      if(data[:linkToForm].present? && data[:linkToResult].present?)
        # Imposta l'utente che ha inserito i dati
        # come utente proprietario del form
        data[:canteen] = current_user
        # Controlla se un questionario per questa data e questo pasto esistono già
        unless Form.where('dateStart=? and dateEnd=?', data[:dateStart], data[:dateEnd]).empty?
          # Comunica un messaggio
          flash[:warning] = 'Already existing questionnaire'
          # Reindirizza l'utente
          redirect_to forms_path
          return
        end
        # Crea un istanza del nuovo questionario
        @form = Form.new(data)
        # Salva il questionario nel db
        res = @form.save
        # Controlla se l'operazione e' andata a buon fine
        # e comunica un messaggio
        if res
          flash[:notice] = 'Questionnaire created'
        else
          flash[:warning] = 'Cannot create Questionnaire'
        end
        # Reindirizza l'utente
        redirect_to new_form_path
      else
        # Comunica un messaggio
        flash[:warning] = 'Incorrect inserted links'
      end
    else
      # Comunica un messaggio
      flash[:warning] = 'Incorrect selected dates'
    end
  end

  # Permette di riflettere le modifiche apportate
  # ad un questionario precedentemente creato sul db
  def update
    authorize! :update, :Form
    # Ottiene i parametri del questionario passati dalla pagina web
    data = params.require(:form).permit(:dateStart, :dateEnd, :linkToForm, :linkToResult, :canteen)
    # Controlla se la data inserita per il form e' corretta
    if(data[:dateStart].to_date() >= Date.today || data[:dateEnd].to_date() > Date.today)
      # Controlla se i link verso le risorse esterne sono stati inseriti
      if(data[:linkToForm].present? && data[:linkToResult].present?)
        # Trova il questionario da modificare
        @form = Form.find(params[:id])
        # Aggiorna i dati del questionario
        res = @form.update(data)
        # Controlla se l'operazione e' andata a buon fine
        # e comunica un messaggio
        if res
          flash[:notice] = 'Questionnaire updated'
        else
          flash[:warning] = 'Cannot update questionnaire'
        end
        # Reindirizza l'utente
        redirect_to forms_path
      else
        # Comunica un messaggio
        flash[:warning] = 'Incorrect inserted links'
      end
    else
      # Comunica un messaggio
      flash[:warning] = 'Incorrect selected dates'
    end
  end

  def destroy
    authorize! :destroy, :Form
    # Trova il menu da eliminare
    @form = Form.find(params[:id])
    # Cencella il menu
    @form.destroy
    # Comunica un messaggio
    flash[:notice] = 'Form deleted'
    # Reindirizza l'utente
    redirect_to forms_path
  end

end
