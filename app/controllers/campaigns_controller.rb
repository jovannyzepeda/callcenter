class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :autenticacion_companygroup
  before_action :auth
  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.activos
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @groups = Group.where("id not in(select group_id from groupcampaigns where(campaign_id = #{@campaign.id}))").activos.map{ |c| [c.nombre, c.id] }
    @newgroup = Groupcampaign.new
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit 
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    
    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    respond_to do |format|
      if @campaign.update(eliminado: true)
        format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to campaigns_url, notice: 'Was ocurred an error' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:nombre) 
    end
end
