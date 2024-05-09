class ContactsController < ApplicationController
  # Antes de executar as ações show, update e destroy, chama o método set_contact
  before_action :set_contact, only: %i[ show update destroy ]

  # GET /contacts
  def index
    # Obtém todos os contatos do banco de dados
    @contacts = Contact.all
    # Renderiza os contatos como JSON para serem exibidos 
    render json: @contacts #, methods: :birthdate_br #[:hello, :i18n]  end
  end
  # GET /contacts/1
  def show
     # Renderiza o contato específico como JSON para ser exibido
     render json: @contact, include: [:kind] #, meta: { author: "Vitor Hugo" } #, include: [:kind, :phones, :address]
  # POST /contacts
  def create
    # Cria um novo contato com base nos parâmetros recebidos
    @contact = Contact.new(contact_params)
    # Se o contato for salvo com sucesso, retorna o contato criado como JSON
    # Caso contrário, retorna os erros de validação como JSON
    if @contact.save
      render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    # Atualiza o contato específico com base nos parâmetros recebidos
    # Retorna o contato atualizado como JSON se for bem-sucedido
    # Caso contrário, retorna os erros de validação como JSON
    if @contact.update(contact_params)
      render json: @contact, include: [:kind, :phones, :address]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy!
  end

  private
    # Método auxiliar para encontrar e atribuir o contato relevante com base no ID fornecido
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # Método auxiliar para especificar quais parâmetros são permitidos para criação ou atualização de um contato
    def contact_params
      params.require(:contact).permit(
        :name, :email, :birthdate, :kind_id,
        phones_attributes: [:id, :number, :_destroy],
        address_attributes: [:id, :street, :city]
      )    end
end
