class ContactabogadosController < ApplicationController
  before_action :set_contact

  # POST /companies
  # POST /companies.json
  def create
    if @contact.contactabogado.present?
      respond_to do |format|
        if @contact.contactabogado.update(filter_params)
          format.html { redirect_to :back, notice: 'The lawyer has been successfully updated.' }
        else
          format.html { redirect_to :back, notice: 'An error has occurred.' }
        end
      end
    else
      @contactabogado = Contactabogado.new(filter_params)
      @contactabogado.contact_id = params[:contact_id]
      respond_to do |format|
        if @contactabogado.save
          format.html { redirect_to :back, notice: 'A lawyer has been successfully integrated.' }
        else
          format.html { redirect_to :back, notice: 'An error has occurred.' }
        end
      end
    end
  end


  private
    def set_contact
      @contact = Contact.find(params[:contact_id])
    end
    def filter_params
      params.require(:contactabogado).permit(:user_id)
    end
end