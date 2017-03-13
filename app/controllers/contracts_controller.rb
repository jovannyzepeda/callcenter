class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy, :cancelled, :updatestatuspayment,:contrato, :pago, :proposal, :legalone, :legaltwo]
  before_action :set_contact
  before_action :autenticacion_companygroup, only: [:destroy]
  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end
  def proposal
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string("contracts/proposal.html.erb", layout: false), margin: {top:0, left:0, right:0,bottom:0})
        send_data pdf, :filename => "propuesta#{@contract.id}.pdf", :type => "application/pdf", :disposition => "attachment"
      end
    end
  end
  def legalone
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string("contracts/legalone.html.erb", layout: false), margin: {top:0, left:0, right:0,bottom:0})
        send_data pdf, :filename => "Legala#{@contract.id}.pdf", :type => "application/pdf", :disposition => "attachment"
      end
    end
  end
  def legaltwo
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string("contracts/legaltwo.html.erb", layout: false), margin: {top:0, left:0, right:0,bottom:0})
        send_data pdf, :filename => "Legalb#{@contract.id}.pdf", :type => "application/pdf", :disposition => "attachment"
      end
    end
  end
  def contrato
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string("contracts/contrato.html.erb", layout: false), margin: {top:0, left:0, right:0,bottom:0})
        send_data pdf, :filename => "contrato#{@contract.id}.pdf", :type => "application/pdf", :disposition => "attachment"
      end
    end
  end
  def cancelled
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string("contracts/cancelacion.html.erb", layout: false), margin: {top:0, left:0, right:0,bottom:0})
        send_data pdf, :filename => "cancelacion#{@contract.id}.pdf", :type => "application/pdf", :disposition => "attachment"
      end
    end
  end
  def pago
    @last_payment = @contract.payments.last
    if @last_payment.blank? || @last_payment.status == true
      @payment = @contract.payments.new
      if @contract.tipo == "Sell"
        @payment.cantidad = @contract.sell_price
      else
        @payment.cantidad = @contract.price_rent
      end
      if @last_payment.present?
        @payment.numero = @last_payment.numero + 1
      else
        @payment.numero = 1
      end
      @payment.user_id = @contract.contact.user.id
      @payment.save
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string("contracts/pago.html.erb", layout: false), margin: {top:0, left:0, right:0,bottom:0})
        send_data pdf, :filename => "payment#{@contract.id}.pdf", :type => "application/pdf", :disposition => "attachment"
      end
    end
  end
  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    if current_user.is_recepcion?
      @contract = current_user.contracts.new(contract_params)
    else
      @contract = current_user.contracts.new(contract_params_normal)
    end
    @contract.contact_id = @contact.id
    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contact, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if current_user.is_recepcion?
        if @contract.update(contract_params)
          format.html { redirect_to :back, notice: 'Contract was successfully updated.' }
        else
          format.html { redirect_to :back, notice: 'was ocurred a problem try again.' }
        end
      else
        if @contact.status.present? and @contact.status != "Process"
            format.html { redirect_to :back, notice: 'You do not have permission to edit a closed sale' }
        else
          if @contract.update(contract_params_normal)
            format.html { redirect_to :back, notice: 'Contract was successfully updated.' }
          else
            format.html { redirect_to :back, notice: 'was ocurred a problem try again.' }
          end
        end
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end
    def set_contact
      @contact = Contact.find(params[:contact_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit( :date, :season, :portfolio_number, :membership, :membership_number, :membership_type, :mail, :sell_price, :number_weeks, :price_week, :price_rent, :tipo, :owner, :commission, :coowner, :lenguaje, :unit_size, :country, :city, :resort)
    end
    def contract_params_normal
      params.require(:contract).permit( :date, :season, :portfolio_number, :membership, :membership_number, :membership_type, :mail, :sell_price, :number_weeks, :price_week, :price_rent, :tipo, :owner, :coowner, :lenguaje, :unit_size, :country, :city, :resort)
    end
end
