class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :autenticacion_companygroup, only:[:edit,:update, :destroy, :new]
  before_action :have_permission?, only: :show
  before_action :set_contract, only: :show
  before_action :auth
  # GET /contracts
  # GET /contracts.json
  def index
    if current_user.is_admin?
      @contacts = Contact.activos.paginate(:page => params[:page], :per_page => 60)
    else
      @contacts = current_user.contacts.paginate(:page => params[:page], :per_page => 60)
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    @historycontact = Historycontact.new
  end


  # GET /contracts/1/edit
  def edit
    @user = Contact.asign_to_user(@contact.campaign_id).map{ |c| [c.nombre, c.id] }
  end


  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    if params[:assign_to].present?
      ContactUser.update_data(@contact.contact_user.user.id,@contact.id, params[:assign_to])
    end
    respond_to do |format|
      if @contact.update(contract_params)
        format.html { redirect_to @contact, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
      respond_to do |format|
        if @contact.update(eliminado: true)
          format.html { redirect_to contacts_path, notice: 'Contract was successfully destroyed.' }
          format.json { head :no_content }
        else
          format.html { redirect_to contacts_path, notice: 'Was ocurred an error try again' }
          format.json { head :no_content }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end
    def have_permission?
      unless current_user.is_admin? || current_user.id = @contact.user.id
        redirect_to :back, notice: "You can view this content"
      end
    end
    def set_contract
      if @contact.contract
        @contract = Contract.find(@contact.contract.id)
      else
        @contract = Contract.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contact).permit(:telefono, :cliente, :status, :date_close, :fax, :correo, :resort, :city, :country, :unit_size, :season)
    end
end