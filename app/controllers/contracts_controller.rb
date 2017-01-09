class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy, :download]
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
  def download
    @template = @contract.contact.campaign.company.templates.where("lenguaje = ?",@contract.lenguaje).last
    papermate = "#{Rails.root}/public#{@template.papermate.url(:original,timestamp: false)}" 
    pdf = Prawn::Document.new
    @template.datatemplates.each do |data|
      pdf.bounding_box([data.left_width-30,710-data.height], :width => data.width, :height => 600 ) do
        pdf.text reemplace_text(data.content,@contract), :size => data.fontsize, :color => data.color
      end
    end
    pdf.page_count.times do |i|
      pdf.go_to_page i
      pdf.image papermate,:at => [-50, 800],:height => 850, :width => 650
    end
    @template.datatemplates.each do |data|
      pdf.bounding_box([data.left_width-30,710-data.height], :width => data.width, :height => 600 ) do
        pdf.text reemplace_text(data.content,@contract), :size => data.fontsize, :color => data.color
      end
    end
    send_data pdf.render, filename: 'Contract_for_user.pdf', type: 'application/pdf' 
  end
  def reemplace_text(text, contrato)
    text = text.gsub('_sell_price', " #{contrato.sell_price}")
    text = text.gsub('_campaign', " #{contrato.contact.campaign.nombre}")
    text = text.gsub('_date', " #{contrato.date}")
    text = text.gsub('_season', " #{contrato.season}")
    text = text.gsub('_portfolio_number', " #{contrato.portfolio_number}")
    text = text.gsub('_membership', " #{contrato.membership}")
    text = text.gsub('_nmembership_number', " #{contrato.membership_number}")
    text = text.gsub('_smembership_size', " #{contrato.membership_size}")
    text = text.gsub('_tmembership_type', " #{contrato.membership_type}")
    text = text.gsub('_mail', " #{contrato.mail}")
    text = text.gsub('_number_weeks', " #{contrato.number_weeks}")
    text = text.gsub('_wprice_week', " #{contrato.price_week}")
    text = text.gsub('_rprice_rent', " #{contrato.price_rent}")
    text = text.gsub('_type', " #{contrato.tipo}")
    text = text.gsub('_owner', " #{contrato.owner}")
    text = text.gsub('_legal_representative', " #{contrato.legal_representative}")
    text = text.gsub('_atipogente', " #{contrato.atipogente}")
    text = text.gsub('_coowner', " #{contrato.coowner}")
    text = text.gsub('_user', " #{contrato.user.nombre}")
    return text
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
      params.require(:contract).permit( :date, :season, :portfolio_number, :membership, :membership_number, :membership_size, :membership_type, :mail, :sell_price, :number_weeks, :price_week, :price_rent, :tipo, :owner, :legal_representative, :atipogente, :commission, :coowner, :lenguaje, :unit_size, :country, :city, :resort)
    end
    def contract_params_normal
      params.require(:contract).permit( :date, :season, :portfolio_number, :membership, :membership_number, :membership_size, :membership_type, :mail, :sell_price, :number_weeks, :price_week, :price_rent, :tipo, :owner, :legal_representative, :atipogente, :coowner, :lenguaje, :unit_size, :country, :city, :resort)
    end
end
