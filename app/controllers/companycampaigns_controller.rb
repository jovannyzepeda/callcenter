class CompanycampaignsController < ApplicationController
	before_action :set_company, only: [:create]
	before_action :autenticacion_companygroup
	def create
		@companycampaign = @company.companycampaign.new(companycampaign_params)

	    respond_to do |format|
	      if @companycampaign.save
	        format.html { redirect_to :back, notice: 'Group was successfully created.' }
	      else
	        format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
	      end
	    end
	end
	def destroy
		@companycampaign = Companycampaign.where(campaign_id: params[:id], company_id: params[:company_id]).first
		if @companycampaign.destroy
		    respond_to do |format|
		      format.html { redirect_to :back, notice: 'Group was destroyed sucessfully.' }
		    end
		else
			respond_to do |format|
		      format.html { redirect_to :back, notice: 'Was ocurred a error try again later.' }
		    end
		end	
		
	end
	def set_company
      @company = Company.find(params[:company_id])
    end
	def companycampaign_params
      params.require(:companycampaign).permit(:campaign_id)
    end
end